"""Candidate replacement SVGs for the image-free uploaded demo bundle."""
from pathlib import Path
import json,html
root=Path(__file__).resolve().parents[1]/'frontend/src/static/icons/wms'
manifest=json.loads((root/'manifest.json').read_text())
box='<rect x="4" y="7" width="16" height="14" rx="2"/><path d="M4 11h16M12 7v5"/>'
truck='<path d="M3 6h11v11H3zM14 10h4l3 4v3h-7"/><circle cx="7" cy="18" r="2"/><circle cx="18" cy="18" r="2"/>'
person='<circle cx="12" cy="7" r="3"/><path d="M5 21v-3a7 7 0 0 1 14 0v3"/>'
sheet='<rect x="5" y="3" width="14" height="18" rx="2"/><path d="M9 8h6M9 12h6M9 16h4"/>'
shelf='<path d="M4 3v18M20 3v18M4 10h16M4 18h16"/><rect x="7" y="4" width="5" height="6" rx="1"/><rect x="12" y="12" width="5" height="6" rx="1"/>'
flower='<circle cx="7" cy="6" r="2"/><circle cx="12" cy="4" r="2"/><circle cx="17" cy="6" r="2"/><path d="m7 8 3 10h4l3-10M12 6v12M9 21h6M9 15h6"/>'
paths={
'collection':'<rect x="3" y="3" width="6" height="6" rx="1"/><rect x="15" y="3" width="6" height="6" rx="1"/><path d="m6 12 6 5 6-5M12 17v4"/>',
'truck':truck,
'checkin':'<path d="M17 9c0 5-5 10-5 10S7 14 7 9a5 5 0 0 1 10 0"/><path d="m10 9 2 2 3-3"/>',
'inspection':'<circle cx="7" cy="5" r="2"/><circle cx="12" cy="4" r="2"/><path d="m7 7 2 11M12 6l-1 10M7 15h5"/><circle cx="16" cy="15" r="4"/><path d="m19 18 3 3"/>',
'warehouse':'<path d="m3 9 9-6 9 6v12H3zM8 21V11h8v10M8 15h8"/>',
'inbound':'<path d="M14 4h6v16h-6M3 12h12m-4-4 4 4-4 4"/>',
'outbound':truck.replace('M3 6h11v11H3z','M3 10v7h11V6H9')+'<path d="M3 4h7M7 1l3 3-3 3"/>',
'shelf':shelf,
'location':'<rect x="3" y="4" width="18" height="16" rx="2"/><path d="M3 12h18M12 4v16"/><circle cx="7.5" cy="8" r="1.5"/>',
'picking':'<path d="M3 3v18M13 3v7M3 10h10M3 18h7"/><rect x="6" y="4" width="4" height="6" rx="1"/><path d="M11 15h10m-3-3 3 3-3 3"/>',
'flower-bunch':flower,
'packing':'<path d="M4 10v10h16V10M4 10l-2-5h7l3 5 3-5h7l-2 5M4 10h16M12 10v10"/>',
'parcel':box+'<path d="M15 15h2M15 18h2"/>',
'dispatch':'<rect x="3" y="4" width="10" height="12" rx="1"/><path d="M3 8h10M8 4v4M12 19h9m-3-3 3 3-3 3"/>',
'scan':'<path d="M3 8V3h5M16 3h5v5M21 16v5h-5M8 21H3v-5M6 12h12"/>',
'sort':'<path d="M3 5h9M3 11h6M3 17h3M17 3v18m-3-3 3 3 3-3M14 6l3-3 3 3"/>',
'stocktake':'<rect x="4" y="3" width="16" height="18" rx="2"/><path d="m7 9 1 1 2-2M13 9h4m-10 7 1 1 2-2M13 16h4"/>',
'replenishment':'<rect x="3" y="8" width="12" height="13" rx="1"/><path d="M3 12h12M9 8v4M18 3v8M14 7h8"/>',
'return':'<rect x="10" y="8" width="11" height="13" rx="1"/><path d="M10 12h11M16 8v4M12 4H4m3-3L4 4l3 3"/>',
'base-return':'<path d="m10 8 6-4 6 4v12H10M14 20v-8h4M9 17H3m3-3-3 3 3 3"/>',
'cold-storage':'<path d="M4 12v9h16v-9M4 15h16M12 15v6M12 3v8M8.5 5l7 4M15.5 5l-7 4M3 11h18"/>',
'crate':'<path d="M3 8h18l-2 13H5zM7 8V5h10v3M8 12v5M12 12v5M16 12v5"/>',
'workbench':'<rect x="3" y="3" width="7" height="7" rx="1"/><rect x="14" y="3" width="7" height="7" rx="1"/><rect x="3" y="14" width="7" height="7" rx="1"/><rect x="14" y="14" width="7" height="7" rx="1"/>',
'message':'<path d="M4 4h16v13H9l-5 4zM8 8h8M8 12h6"/>',
'account':person,
'system-account':'<rect x="3" y="5" width="18" height="14" rx="2"/><circle cx="8" cy="10" r="2"/><path d="M5 16a3 3 0 0 1 6 0M14 9h4M14 13h4"/>',
'distribution-permission':'<circle cx="7" cy="7" r="3"/><path d="M2 20v-3a5 5 0 0 1 10 0v3"/><rect x="15" y="5" width="6" height="14" rx="1"/><path d="M15 12h6"/>',
'inspection-attendance':'<rect x="3" y="5" width="18" height="16" rx="2"/><path d="M7 3v4M17 3v4M3 10h18"/><circle cx="8" cy="15" r="1.5"/><path d="M13 15h4M13 18h4"/>',
'part-logistics':'<circle cx="8" cy="6" r="3"/><path d="M2 20v-3a6 6 0 0 1 9-5"/><circle cx="17" cy="17" r="5"/><path d="M17 14v3h2"/>',
'warehouse-income':'<path d="M4 7V5h13M4 7h16v14H4zM14 11h7v6h-7z"/><circle cx="17" cy="14" r="1"/>',
'inventory':'<rect x="8" y="3" width="8" height="7" rx="1"/><rect x="3" y="13" width="8" height="8" rx="1"/><rect x="13" y="13" width="8" height="8" rx="1"/><path d="M12 3v3M7 13v3M17 13v3"/>',
'team-account':'<circle cx="8" cy="7" r="3"/><circle cx="17" cy="8" r="2.5"/><path d="M2 21v-3a6 6 0 0 1 12 0v3M15 14a5 5 0 0 1 7 4v3"/>',
'team-picking':'<circle cx="7" cy="6" r="3"/><path d="M2 20v-3a5 5 0 0 1 10 0v3M15 5h7M15 10h7M15 15h4M15 20h7"/>',
'patrol-punishment':'<path d="M4 21V4h10M4 9h6M4 15h4"/><path d="m17 11 5 9H12zM17 15v1M17 18h.01"/>',
'access-control':'<path d="m12 3 8 3v6c0 5-8 9-8 9s-8-4-8-9V6zM12 8v4M8 16v-4h8v4"/>',
'bulk-demand':sheet.replace('M9 8h6','M9 8h6M12 5v6'),
'bulk-order':'<rect x="4" y="3" width="14" height="18" rx="2"/><path d="M8 8h6M8 12h6m4 5 2 2 3-4"/>',
'agri-delivery':'<path d="M3 3h11v18H3M6 7h5M6 11h5M14 11h4l3 4v3h-7"/><circle cx="17" cy="19" r="2"/>',
'agri-order':'<rect x="4" y="3" width="14" height="18" rx="2"/><path d="M8 7h6M8 11h4m4 6 2 2 4-4"/>',
 'task':sheet,
}
for item in manifest['icons']:
    key=item['id'].removeprefix('fwms-').removesuffix('-outline')
    body=paths[key]
    svg='<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><title>'+html.escape(item['label'])+'</title>'+body+'</svg>\n'
    (root/item['file']).write_text(svg)
    item.update(status='candidate',icon_version='2.0.0',reference_ids=item.get('reference_ids',[]),aliases=item.get('aliases',[]),optical_adjustments='24px 线性候选图标，用于无图片源码包的云端演示',source='cloud-demo-restoration',approval_record='pending')
(root/'manifest.json').write_text(json.dumps(manifest,ensure_ascii=False,indent=2)+'\n')
preview=['<!doctype html><meta charset="utf-8"><title>演示候选图标</title><style>body{font:14px sans-serif;background:#f3f7f6;color:#172b29}.grid{display:grid;grid-template-columns:repeat(5,1fr);gap:12px}.cell{padding:18px;background:white}.dark{background:#172b29;color:white}.sizes{display:flex;gap:16px;align-items:center;margin:12px 0}</style><h1>演示候选图标 · 24 / 20 / 16px</h1><div class="grid">']
for item in manifest['icons']:
    svg=(root/item['file']).read_text()
    for dark in [False,True]:
        preview.append('<div class="cell'+(' dark' if dark else '')+'">'+html.escape(item['label'])+'<div class="sizes">'+''.join(svg.replace('width="24" height="24"',f'width="{size}" height="{size}"') for size in [24,20,16])+'</div></div>')
preview.append('</div>');(root/'candidate-preview.html').write_text('\n'.join(preview))
print('Restored',len(manifest['icons']),'candidate icons')
