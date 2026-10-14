import { request } from "@/shared/api/client";
import type {
  PartLogisticsLeader,
  PartLogisticsOverview,
} from "../models/part-logistics";

export const partLogisticsApi = {
  overview(date: string) {
    return request<PartLogisticsOverview>({
      url: `/part-logistics/overview?date=${encodeURIComponent(date)}`,
      method: "GET",
    });
  },
  leaders() {
    return request<PartLogisticsLeader[]>({
      url: "/part-logistics/leaders",
      method: "GET",
    });
  },
  assign(ids: number[], leaderId: number) {
    return request<{ affected: number }>({
      url: "/part-logistics/assign",
      method: "POST",
      data: { ids, leaderId },
    });
  },
};
