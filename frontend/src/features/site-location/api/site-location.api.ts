import { request } from "@/shared/api/client";
import type { SiteLocationStatistics } from "../models/site-location";

export const siteLocationApi = {
  statistics() {
    return request<SiteLocationStatistics>({ url: "/site-locations", method: "GET" });
  },
};
