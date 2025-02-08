import subprocess
import glob
from lib.constants import CONFIG_DIR

def get_blueprints():
    return glob.glob(str(CONFIG_DIR / "res/blueprints/*.blp"))

def compile_blueprints():
    in_dir = str(CONFIG_DIR / "res/ui")
    out_dir = str(CONFIG_DIR / "res/blueprints")
    subprocess.check_call(["blueprint-compiler", "batch-compile", in_dir, out_dir, *get_blueprints()])

compile_blueprints()