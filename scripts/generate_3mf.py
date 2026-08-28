#!/usr/bin/env python3
"""
Generate ready-to-print .3MF Project Files for PrusaSlicer 2.9+.
Pre-configured for:
- Printer: Original Prusa MK4S (0.4mm nozzle / HF0.4)
- Filament: Overture PETG / Generic PETG
- Print Profile: 0.20mm STRUCTURAL (4 perimeters, 5 top/bottom layers, 20% Gyroid infill, 0 supports)
"""

import os
import zipfile
import trimesh

MODELS = [
    ("ps5-fat-fit-test.stl", "ps5-fat-fit-test.3mf", "PS5 Fat Fit Test Coupon"),
    ("ps5-fat-vertical-stand.stl", "ps5-fat-vertical-stand.3mf", "PS5 Fat Vertical Stand (Sony Screw)"),
    ("ps5-fat-vertical-stand-alt-fastener.stl", "ps5-fat-vertical-stand-alt-fastener.3mf", "PS5 Fat Vertical Stand (M3 Hardware)"),
]

# Prusa MK4S Bed Dimensions: 250 x 210 mm (Center at X=125, Y=105)
BED_CENTER_X = 125.0
BED_CENTER_Y = 105.0

def create_3mf(stl_path: str, out_3mf_path: str, title: str):
    if not os.path.exists(stl_path):
        print(f"Error: {stl_path} not found.")
        return
        
    mesh = trimesh.load(stl_path)
    
    # Generate 3MF Model XML
    vertices_xml = '\n'.join([f'        <vertex x="{v[0]:.4f}" y="{v[1]:.4f}" z="{v[2]:.4f}" />' for v in mesh.vertices])
    triangles_xml = '\n'.join([f'        <triangle v1="{f[0]}" v2="{f[1]}" v3="{f[2]}" />' for f in mesh.faces])

    model_xml = f'''<?xml version="1.0" encoding="UTF-8"?>
<model unit="millimeter" xml:lang="en-US" xmlns="http://schemas.microsoft.com/3dmanufacturing/core/2015/02">
  <metadata name="Title">{title}</metadata>
  <metadata name="Application">PrusaSlicer-2.9.6</metadata>
  <resources>
    <object id="1" type="model">
      <mesh>
        <vertices>
{vertices_xml}
        </vertices>
        <triangles>
{triangles_xml}
        </triangles>
      </mesh>
    </object>
  </resources>
  <build>
    <item objectid="1" transform="1 0 0 0 1 0 0 0 1 {BED_CENTER_X:.1f} {BED_CENTER_Y:.1f} 0" />
  </build>
</model>'''

    content_types = '''<?xml version="1.0" encoding="UTF-8"?>
<Types xmlns="http://schemas.openxmlformats.org/package/2006/content-types">
  <Default Extension="rels" ContentType="application/vnd.openxmlformats-package.relationships+xml" />
  <Default Extension="model" ContentType="application/vnd.ms-package.3dmanufacturing-3dmodel+xml" />
  <Default Extension="config" ContentType="text/plain" />
</Types>'''

    rels = '''<?xml version="1.0" encoding="UTF-8"?>
<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">
  <Relationship Target="/3D/3dmodel.model" Id="rel0" Type="http://schemas.microsoft.com/3dmanufacturing/2013/01/3dmodel" />
</Relationships>'''

    # PrusaSlicer MK4S + Overture PETG Preset Configuration
    config_ini = '''# PrusaSlicer Project Configuration for Prusa MK4S
# Base Profile: 0.20mm STRUCTURAL @MK4S
layer_height = 0.20
first_layer_height = 0.20
perimeters = 4
top_solid_layers = 5
bottom_solid_layers = 5
fill_density = 20%
fill_pattern = gyroid
support_material = 0
support_material_auto = 0
brim_width = 0
ironing = 0

# Filament Configuration: Overture PETG
filament_type = PETG
temperature = 240
first_layer_temperature = 240
bed_temperature = 85
first_layer_bed_temperature = 85
cooling = 1
min_fan_speed = 30
max_fan_speed = 50

# Printer Configuration: Original Prusa MK4S HF0.4
printer_model = MK4S
printer_variant = HF0.4
nozzle_diameter = 0.4
'''

    with zipfile.ZipFile(out_3mf_path, 'w', zipfile.ZIP_DEFLATED) as z:
        z.writestr('[Content_Types].xml', content_types)
        z.writestr('_rels/.rels', rels)
        z.writestr('3D/3dmodel.model', model_xml)
        z.writestr('Metadata/Slic3r_PE.config', config_ini)
        z.writestr('Metadata/Prusa_Slicer.config', config_ini)

    print(f"Generated: {out_3mf_path} ({os.path.getsize(out_3mf_path)/1024.0:.1f} KB)")

def main():
    os.chdir(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
    print("Generating PrusaSlicer .3MF Project Files...")
    for stl, out_3mf, title in MODELS:
        create_3mf(stl, out_3mf, title)
    print("All .3MF project files generated successfully!")

if __name__ == "__main__":
    main()
