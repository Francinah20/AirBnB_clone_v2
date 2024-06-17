from fabric.api import env
from do_pack import do_pack
from do_deploy import do_deploy

env.hosts = ['<IP web-01>', '<IP web-02>']

def deploy():
    """
    Creates and distributes an archive to the web servers.
    """
    archive_path = do_pack()
    if not archive_path:
        return False
    return do_deploy(archive_path)

