export interface PackingShelf {date:string;shelfSn:number;zone:string;shelfNo:string;status:number;selfPickup:boolean;restockStatus:number;earlyShift:boolean;boxMismatch:boolean;deliveryTime:string;packageCount:number;completedCount:number;itemNum:number}
export interface PackingPackage {id:number;date:string;shelfSn:number;shelfNo:string;serialNum:number;sendNo:string;city:string;itemNum:number;status:number;boxId:number;boxName:string;suggestBoxId:number;suggestBoxName:string;boxMismatch:boolean;cottonNum:number;boardNum:number;bagNum:number;expressName:string;receiveName:string;receiveTel:string;receiveAddress:string;remark:string;photos:string[];packageUserName:string;packageTime:string|null;earlyShift:boolean}
export interface PackingShelfDetail extends PackingShelf {packages:PackingPackage[]}
export interface BoxType{id:number;name:string}
export interface PackingStatistics{total:number;completed:number;pending:number;shelves:number;packers:number}
export interface PackingSizeStatistic{total:number;large:number;regular:number;small:number;extraSmall:number}
export interface PackingPackagingStatistic{name:string;num:number}
export interface PackingZoneWeightStatistic{zone:string;shelfNum:number;totalWeight:number}
export interface PackingIncomeStatistic{id:number;packageUserId:number;packageUserName:string;wareName:string;shelfNo:string;totalWeight:number;price:number}
export interface PackingCottonStatistic{shelfNo:string;num:number}
export interface PackingCottonSummary{total:number;rows:PackingCottonStatistic[]}
