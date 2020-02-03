#!/usr/bin/env python3
import re
import sys
import os
import argparse  # argument parsing

# Parse and validate arguments
# ==============================================================================
parser = argparse.ArgumentParser(
    description='Adds padding to the right of all macros in a lef file')
parser.add_argument('--right', '-r', required=True, type=int,
                    help='Padding on the right in SITE widths')
parser.add_argument('--left', '-l', required=True, type=int,
                    help='Padding on the left in SITE widths')
parser.add_argument('--top', '-t', required=True, type=int,
                    help='Padding on the top in SITE heights')
parser.add_argument('--bottom', '-b', required=True, type=int,
                    help='Padding on the bottom in SITE heights')
parser.add_argument('--site', '-s', required=True,
                    help='Lef SITE')
parser.add_argument('--exclude', '-e', required=False,
                    default='ENDCAPTIE* CNRCAP* INCNR* TBCAP* FILL* WELLTAP* tsmc65lp_* gf14_* fakeram45_*',
                    help='exclude')
parser.add_argument('--inputLef', '-i', required=True,
                    help='Input LEF')
parser.add_argument('--outputLef', '-o', required=True,
                    help='Output LEF')
args = parser.parse_args()

REGEXNUM = "-?\d+\.?\d*"

def replace_size(match):
  m = match.groups()
  newWidth = float(m[0]) + right_padding + left_padding
  newHeight = float(m[1]) + top_padding + bottom_padding
  return "SIZE " + '{0:g}'.format(newWidth) + " BY " + '{0:g}'.format(newHeight)

def replace_rect(match):
  m = match.groups()
  pt1 = '{0:g}'.format(float(m[0]) + left_padding) + " " + '{0:g}'.format(float(m[1]) + bottom_padding)
  pt2 = '{0:g}'.format(float(m[2]) + left_padding) + " " + '{0:g}'.format(float(m[3]) + bottom_padding)
  return "RECT " + pt1 + " " + pt2

def replace_rectMask(match):
  m = match.groups()
  pt1 = '{0:g}'.format(float(m[1]) + left_padding) + " " + '{0:g}'.format(float(m[2]) + bottom_padding)
  pt2 = '{0:g}'.format(float(m[3]) + left_padding) + " " + '{0:g}'.format(float(m[4]) + bottom_padding)
  return "RECT MASK " + str(m[0]) + " " + pt1 + " " + pt2

# Function used by re.sub
def replace_pad(match):
  m = match.groups()
  skip = 0

  # Check if it's a MACRO to be skipped
  for pattern in args.exclude.split():
    if re.match(pattern, m[0]):
      print('Skipping LEF padding for MACRO ', m[0])
      return match.group()

  returnString = match.group()

  # Pad SIZE
  sizePattern = f"^\s*SIZE\s+({REGEXNUM})\s+BY\s+({REGEXNUM})"
  returnString = re.sub(sizePattern, replace_size, returnString, 0, re.M | re.DOTALL)

  # Pad RECTs
  rectPattern = f"^\s*RECT\s+({REGEXNUM})\s+({REGEXNUM})\s+({REGEXNUM})\s+({REGEXNUM})"
  returnString = re.sub(rectPattern, replace_rect, returnString, 0, re.M | re.DOTALL)

  # Pad RECT MASKs
  rectMastPattern = f"^\s*RECT\s+MASK\s+({REGEXNUM})\s+({REGEXNUM})\s+({REGEXNUM})\s+({REGEXNUM})"
  returnString = re.sub(rectMastPattern, replace_rectMask, returnString, 0, re.M | re.DOTALL)

  return returnString


print(os.path.basename(__file__),": Padding technology lef file")

# Read input file
f = open(args.inputLef)
content = f.read()
f.close()

# Find SITE width
sitePattern = f"^SITE\s+{args.site}.*SIZE\s+({REGEXNUM})\s+BY\s+({REGEXNUM}).*END\s+{args.site}"
m = re.search(sitePattern, content, re.M | re.DOTALL)

if m:
  site_width = float(m.group(1))
  site_height = float(m.group(2))
  right_padding = float(args.right) * site_width
  left_padding = float(args.left) * site_width
  top_padding = float(args.top) * site_height
  bottom_padding = float(args.bottom) * site_height
else:
  raise ValueError("Error: Pattern search for SITE size failed")

print("Derived SITE width (microns): " + str(site_width))
print("Derived SITE height (microns): " + str(site_height))
print("Right cell padding (microns): " + str(right_padding))
print("Left cell padding (microns): " + str(left_padding))
print("Top cell padding (microns): " + str(top_padding))
print("Bottom cell padding (microns): " + str(bottom_padding))


# Perform substitution on every macro
pattern = r"^MACRO\s+(\S+).*?^END\s\S+"
result, count = re.subn(pattern, replace_pad, content, 0, re.M | re.DOTALL)

# Write output file
f = open(args.outputLef, "w")
f.write(result)
f.close()

# Check
if count < 1:
  print("WARNING: Replacement pattern not found")
  # sys.exit(1)

print(os.path.basename(__file__),": Finished")
