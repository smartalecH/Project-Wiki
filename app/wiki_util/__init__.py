import os, logging, time
from .. import basedir

log_file_handler = logging.FileHandler( \
    os.path.join(basedir, 'Project_Wiki_Data', 'log', '%s.log' % time.strftime('%Y%m%d_%H%M%S')))
log_file_handler.setLevel(logging.WARNING)
formatter = logging.Formatter('%(asctime)s - %(levelname)s - %(message)s')
log_file_handler.setFormatter(formatter)