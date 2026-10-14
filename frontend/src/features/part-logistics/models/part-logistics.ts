export interface PartLogisticsRecord {
  id: number;
  date: string;
  userId: number;
  userName: string;
  leaderId: number;
  leaderName: string;
  startCheckerName: string;
  endCheckerName: string;
  startTime: string | null;
  endTime: string | null;
  duration: number;
  unitPrice: number;
  totalPrice: number;
  settled: boolean;
}
export interface PartLogisticsOverview {
  summary: {
    assigned: number;
    checked: number;
    ended: number;
  };
  assignedRecords: PartLogisticsRecord[];
  checkedRecords: PartLogisticsRecord[];
}
export interface PartLogisticsLeader {
  id: number;
  name: string;
}
