export type SiteLocationSizeType = "large" | "regular" | "small" | "extraSmall";

export interface SiteLocationSummaryItem {
  type: SiteLocationSizeType;
  label: string;
  enabled: number;
  disabled: number;
}

export interface SiteLocationDetail {
  key: string;
  zoneCode: string;
  zoneName: string;
  segmentName: string;
  startShelf: number;
  endShelf: number;
  count: number;
  sizeType: SiteLocationSizeType;
  sizeLabel: string;
  enabled: boolean;
  areaKind: string;
}

export interface SiteLocationStatistics {
  summary: SiteLocationSummaryItem[];
  details: SiteLocationDetail[];
}
