INSERT INTO wms_permission(parent_id,code,name,domain_code,permission_type,description,route_path,icon,sort_order,status) VALUES
(0,'distributionStaff.view','配货权限','distribution-staff',1,'查看配货人员及可配分区','/features/workforce/pages/distribution-staff/index','fwms-account-outline',130,1),
(0,'inspectionAttendance.view','质检假勤','inspection-attendance',1,'查看质检人员出勤和休息状态','/features/workforce/pages/inspection-attendance/index','fwms-task-outline',131,1)
ON DUPLICATE KEY UPDATE name=VALUES(name),domain_code=VALUES(domain_code),permission_type=1,description=VALUES(description),route_path=VALUES(route_path),icon=VALUES(icon),sort_order=VALUES(sort_order),status=1;

INSERT INTO wms_permission(parent_id,code,name,domain_code,permission_type,description,route_path,icon,sort_order,status)
SELECT id,'distributionStaff.configure','配置配货分区','distribution-staff',2,'单人或批量配置配货员可配分区','','',10,1 FROM wms_permission WHERE code='distributionStaff.view'
ON DUPLICATE KEY UPDATE parent_id=VALUES(parent_id),name=VALUES(name),domain_code=VALUES(domain_code),permission_type=2,description=VALUES(description),status=1;
INSERT INTO wms_permission(parent_id,code,name,domain_code,permission_type,description,route_path,icon,sort_order,status)
SELECT id,'inspectionAttendance.update','调整质检假勤','inspection-attendance',2,'将质检人员设为出勤或休息并记录日志','','',10,1 FROM wms_permission WHERE code='inspectionAttendance.view'
ON DUPLICATE KEY UPDATE parent_id=VALUES(parent_id),name=VALUES(name),domain_code=VALUES(domain_code),permission_type=2,description=VALUES(description),status=1;

INSERT INTO wms_permission_group(code,name,description,status) VALUES
('distribution_staff_management','配货权限','查看配货人员并配置可配分区',1),
('inspection_attendance_management','质检假勤','查看并调整质检人员假勤',1)
ON DUPLICATE KEY UPDATE name=VALUES(name),description=VALUES(description),status=1;
INSERT IGNORE INTO wms_permission_group_item(group_id,permission_id)
SELECT g.id,p.id FROM wms_permission_group g JOIN wms_permission p ON
(g.code='distribution_staff_management' AND p.code IN ('distributionStaff.view','distributionStaff.configure')) OR
(g.code='inspection_attendance_management' AND p.code IN ('inspectionAttendance.view','inspectionAttendance.update'));
INSERT IGNORE INTO wms_role_permission_group(role_id,group_id)
SELECT r.id,g.id FROM wms_role r JOIN wms_permission_group g
WHERE r.code='siteAdmin' AND g.code IN ('distribution_staff_management','inspection_attendance_management');
