import * as repository from "./site-location.repository.js";

type SizeType = "large" | "regular" | "small" | "extraSmall";
type RangeConfig = { startShelf: number; endShelf: number; sortConfig?: number; name?: string };

const sizeLabel: Record<SizeType, string> = {
  large: "大件",
  regular: "正常件",
  small: "小件",
  extraSmall: "特小件",
};

function parseRanges(value: unknown): RangeConfig[] {
  try {
    const parsed = JSON.parse(String(value || "[]"));
    return Array.isArray(parsed) ? parsed : [];
  } catch {
    return [];
  }
}

function sizeType(sortConfig: number): SizeType {
  if (sortConfig === 2) return "large";
  if (sortConfig === 1) return "small";
  if (sortConfig === 4) return "extraSmall";
  return "regular";
}

function areaKind(wareType: number, standby: number) {
  if (wareType === 1) return "城市仓";
  if (standby === 1) return "备用区";
  if (standby === 2) return "虚拟区";
  return "主场区";
}

export async function getSiteLocations() {
  const rows = await repository.listAreaConfigs();
  const details = rows.flatMap((row) => {
    const sizeRanges = parseRanges(row.sub_area);
    const segmentRanges = parseRanges(row.segment_area);
    const ranges = sizeRanges.length
      ? sizeRanges
      : [{ startShelf: Number(row.start_shelf), endShelf: Number(row.end_shelf), sortConfig: Number(row.sort_config) }];
    return ranges.map((range, index) => {
      const startShelf = Number(range.startShelf || row.start_shelf);
      const endShelf = Number(range.endShelf || row.end_shelf);
      const type = sizeType(Number(range.sortConfig ?? row.sort_config));
      const segment = segmentRanges.find((item) => Number(item.startShelf) === startShelf && Number(item.endShelf) === endShelf);
      return {
        key: `${row.code}-${startShelf}-${endShelf}-${index}`,
        zoneCode: String(row.code),
        zoneName: String(row.area_name || `${row.code}区`),
        segmentName: String(segment?.name || index + 1),
        startShelf,
        endShelf,
        count: Math.max(0, endShelf - startShelf + 1),
        sizeType: type,
        sizeLabel: sizeLabel[type],
        enabled: Number(row.status) === 1,
        areaKind: areaKind(Number(row.ware_type), Number(row.standby)),
      };
    });
  });
  const summary = (["large", "regular", "small", "extraSmall"] as SizeType[]).map((type) => ({
    type,
    label: sizeLabel[type],
    enabled: details.filter((item) => item.sizeType === type && item.enabled).reduce((sum, item) => sum + item.count, 0),
    disabled: details.filter((item) => item.sizeType === type && !item.enabled).reduce((sum, item) => sum + item.count, 0),
  }));
  return { summary, details };
}
