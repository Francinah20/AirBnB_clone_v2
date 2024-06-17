from fabric.api import env, put, run
import os

# Define the hosts to deploy to
env.hosts = ['<IP web-01>', '<IP web-02>']

def do_deploy(archive_path):
    """
    Distributes an archive to the web servers.
    """
    # Check if the archive exists
    if not os.path.exists(archive_path):
        return False

    # Extract the archive file name and base name
    archive_file = archive_path.split("/")[-1]
    archive_base = archive_file.split(".")[0]
    release_folder = f"/data/web_static/releases/{archive_base}/"

    try:
        # Upload the archive to /tmp/ directory on the web server
        put(archive_path, f"/tmp/{archive_file}")

        # Create the release folder
        run(f"mkdir -p {release_folder}")

        # Uncompress the archive to the release folder
        run(f"tar -xzf /tmp/{archive_file} -C {release_folder}")

        # Delete the archive from the web server
        run(f"rm /tmp/{archive_file}")

        # Move the contents out of the web_static sub-folder
        run(f"mv {release_folder}web_static/* {release_folder}")

        # Delete the empty web_static folder
        run(f"rm -rf {release_folder}web_static")

        # Delete the symbolic link current
        run("rm -rf /data/web_static/current")

        # Create a new symbolic link
        run(f"ln -s {release_folder} /data/web_static/current")

        print("New version deployed!")
        return True

    except:
        return False

