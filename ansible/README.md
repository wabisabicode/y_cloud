# Ansible Roles

This directory contains the Ansible roles used to configure the virtual machines provisioned by Terraform.

## Role Descriptions

### `default_y_packages`
This role performs the initial server setup on all machines.
* **Tasks:**
    * Sets the machine's hostname to match its name in the Ansible inventory (`vm1`, `vm2`, or `vm3`).
    * Updates the `apt` package cache.
    * Installs a set of standard utility packages: `net-tools`, `dnsutils`, `wget`, `curl`, `mc`, `rsync`.

### `nginx_proxy`
This role configures one VM (the `pnginx` group) to act as a reverse proxy.
* **Tasks:**
    * Installs Nginx.
    * Deploys a configuration file (`nginx.conf.j2`) that listens on port `3000`.
    * Forwards all incoming requests to the servers in the `snginx` group in a round-robin fashion.
    * Enables the new proxy configuration and disables the default Nginx site.
    * Restarts the Nginx service to apply changes.

### `nginx_send`
This role configures the web server VMs (the `snginx` group).
* **Tasks:**
    * Installs Nginx.
    * Deploys a simple `index.html` page using a template (`index.j2`).
    * The page displays the message "Hello from `{{ inventory_hostname }}`!", showing which server is responding.
    * Ensures the Nginx service is running.
