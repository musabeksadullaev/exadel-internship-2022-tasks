## Important points - 1

System configuration management  helps to define system state with code.

It can be reused further.

Popular system configuration management tools are Ansible, Chef, Puppet



## Important points - 2

- Advantages and disadvantages of Ansible over other tools (compared to Chef and Puppet):
  - Advantages (of Ansible):
    - Relatively simple than other System configuration management tools
    - Easy installation
    - Agentless (No need to install other tools on target. All you need is Python (2/3) and SSH server on target)
    - Very high scalability
    - Playbooks can be created with YAML and Python
    - Relatively cheap (than Chef and Puppet)
  - Disadvantages (of Ansible):
    - Don't support more features (like Puppet) (but enough for everyday usage)
    - Small support of enterprise


## Important points - 3
### Ansible basics

- Each action that will be runned on remote host is named **task**
- There's 2 main ways/modes/methods of usage of Ansible. **Ad-Hoc** and **Playbook**:
  - Ad-Hoc - Mostly used to run single task on remote hosts (ping hosts, one-time commands, ...)
    - This method is runned only once
  - Playbook - Used to run multiple tasks on remote hosts (Installing Docker, Set-up system, Install packages and more and more)
    - This method is reusable

- After installing Ansible you need to add remote hosts/inventory/targets to file `/etc/ansible/hosts`
  - Inventory file can be in 2 formats - INI and YAML
  - Inventory file in INI format can look like this:
   ``` ini
    # You can use simple list of targets ...
    [apps]
    1.2.3.4
    5.6.7.8
    9.10.11.12

    # And variables and connection params for all targets in group
    [apps:vars]
    ansible_connection              = ssh       # Use SSH connection
    ansible_user                    = user      # Username/login for logging in to server
    ansible_ssh_password            = PaSsWoRd  # Password for logging in to server
    ansible_ssh_private_key_file    = priv.key  # Private key for logging in to server

    # ... or range of targets that can be generated automatically. This will be resolved to next values:
    # backend-01.app.com
    # backend-02.app.com
    # backend-03.app.com
    # backend-04.app.com
    # backend-05.app.com
    [backends-list]
    backend-[01:05].app.com

    [backends-list:vars]
    ansible_connection              = ssh       # Use SSH connection
    ansible_user                    = user      # Username/login for logging in to server
    ansible_ssh_password            = PaSsWoRd  # Password for logging in to server
    ansible_ssh_private_key_file    = priv.key  # Private key for logging in to server


    # ... or range of targets that even values skipped. This will be resolved to next values:
    # backend-01.app.com
    # backend-03.app.com
    # backend-05.app.com
    # backend-07.app.com
    [backends-odd]
    backend-[01:08:2].app.com

    [backends-odd:vars]
    ansible_connection              = ssh       # Use SSH connection
    ansible_user                    = user      # Username/login for logging in to server
    ansible_ssh_password            = PaSsWoRd  # Password for logging in to server
    ansible_ssh_private_key_file    = priv.key  # Private key for logging in to server


    # ... or range of targets with alphabetic values. This will be resolved to next values:
    # region-a.backend.app.com
    # region-b.backend.app.com
    # region-c.backend.app.com
    # region-d.backend.app.com
    # region-e.backend.app.com
    [backends-regions]
    region-[a-e].backend.app.com

    [backends-regions:vars]
    ansible_connection              = ssh       # Use SSH connection
    ansible_user                    = user      # Username/login for logging in to server
    ansible_ssh_password            = PaSsWoRd  # Password for logging in to server
    ansible_ssh_private_key_file    = priv.key  # Private key for logging in to server


    # You can group multiple host groups to another group
    [backends-all]
    backends-list
    backends-odd
    backends-regions

    [backends-all:vars]
    ansible_connection              = ssh       # Use SSH connection
    ansible_user                    = user      # Username/login for logging in to server
    ansible_ssh_password            = PaSsWoRd  # Password for logging in to server
    ansible_ssh_private_key_file    = priv.key  # Private key for logging in to server
    ```

- After adding hosts to your hosts file you need to select method of usage.

  > If you select **Ad-Hoc** method you can complete only one task with one command \
    For example you can ping target servers with one command: `ansible backends-all -m ping`

  > If you select **Playbook** method you can complete multiple tasks with one playbook file that contains all commands \
    For example you can update and upgrade packages, install Docker engine, add/remove/modify users and groups on target hosts:
    ``` yaml
    ---
    - name: "Set-up Ubuntu"
      become: true
      hosts: backends-all
      vars_files:
        - ./vars.yaml

      tasks:
      - name: "Update and upgrade packages in system"
        apt:
          upgrade: yes
          update_cache: yes

      - name: "Install nginx, htop, nano and net-tools"
        apt:
          status: present
          pkg:
          - nginx
          - htop=3.2
          - nano
          - net-tools

      - name: "Install OnlyOffice from downloaded deb package"
        apt:
          deb: /tmp/only_office_v1.2.3.deb

      - name: "Add user named 'johndoe' to system with comment and append to groups named `admins` and `devs`"
        ansible.builtin.user:
          name: johndoe
          comment: John Doe
          groups: admins,devs
          append: yes

      - name: "Remove user 'johndoe'"
        ansible.builtin.user:
          name: johndoe
          state: absent
          remove: yes
    ```
  Apply changes with command `ansible-playbook main.yaml`
  Process result will end with next line:
  ```
  # ...
  X.X.X.X    : ok=X     changed=X   unreachable=X   failed=X    skipped=X      rescued=X   ignored=X

  # ^ (1)      ^ (2)    ^ (3)       ^ (4)           ^ (5)       ^ (6)          ^ (7)       ^ (8)
  ```

  Output has these indicators:
  1. `X.X.X.X`       - IP address / domain of target system
  2. `ok`            - Changes applied before
  3. `changed`       - Target is changed
  4. `unreachable`   - Unable to connect to target
  5. `failed`        - Failed to modify target
  6. `skipped`       - Target is skipped (e.g. affected `if` condition)
  7. `rescued`       - Target is rescued (.........................)
  8. `ignored`       - Target is ignored (.........................)


## Important points - Extra

> [Jinja2](https://jinja.palletsprojects.com/en/3.1.x/) is a templating language used to generate dynamic content.

> There's 2 types of delimiters - **expressions** and **statements**

> Statements - Control structures that helps to select which part of code to generate

There's have next key statements in Jinja2:
- if - Can be used to select which part of code to display:
  ``` jinja2
    {% if users %}
      <p>Users found</p>
    {% else %}
      <p>No users found</p>
    {% endif %}

    {% if user.id % 2 == 0 %}
      <p>User id is even</p>
    {% else %}
      <p>User id is odd</p>
    {% endif %}
  ```
- for - Can be used to loop over list of items or key/value structure:
  ``` jinja2
    <ul>
      {% for user in users %}
        <li>({{ user.id }}) {{ user.name }}</li>
      {% endfor %}
    </ul>
  ```
- set - Set variable inside code
  ``` jinja2
    {% set cities = ['New York', 'Washington', 'Miami', 'Los Angeles', 'London'] %}

    {% for city in cities %}
        {{ city }}
    {% endfor %}
  ```

- extends - Include another existing template (Parent inheritance)
  Contents of `base.html`:
  ``` jinja2
    <!DOCTYPE html>
    <html>
    <head>
      <meta charset="utf-8">
      <meta name="viewport" content="width=device-width, initial-scale=1">
      <title>Page title</title>
    </head>
    <body>

      <header>
        <h1>Page title</h1>
      </header>

      <aside>
        {% block menu %}{% endblock menu %}
      </aside>

      <main>
        {% block content %}{% endblock content %}
      </main>

      <footer>
        <h1>Page extra text</h1>
      </footer>

    </body>
    </html>
  ```

  Contents of `index.html`:
  ``` jinja2
    {% block content %}
      <p>Lorem ipsum dolor sit amet</p>
    {% endblock content %}

    {% block menu %}
      <ul>
        <li><a href="/">Home</a></li>
        <li><a href="/news">News</a></li>
      </ul>
    {% endblock menu %}
  ```

  Result:
  ``` jinja2
    <!DOCTYPE html>
    <html>
    <head>
      <meta charset="utf-8">
      <meta name="viewport" content="width=device-width, initial-scale=1">
      <title>Page title</title>
    </head>
    <body>

      <header>
        <h1>Page title</h1>
      </header>

      <aside>
        <ul>
          <li><a href="/">Home</a></li>
          <li><a href="/news">News</a></li>
        </ul>
      </aside>

      <main>
        <p>Lorem ipsum dolor sit amet</p>
      </main>

      <footer>
        <h1>Page extra text</h1>
      </footer>

    </body>
    </html>
  ```

- include - Used when to include another Jinja2 template
  Contents of `base.html`:
  ``` jinja2
    <!DOCTYPE html>
    <html>
    <head>
      <meta charset="utf-8">
      <meta name="viewport" content="width=device-width, initial-scale=1">
      <title>Page title</title>
    </head>
    <body>

      {% include 'header.html' %}

      {% include 'menu.html' %}

      {% block content %}{% endblock %}

      {% include 'footer.html' %}

    </body>
    </html>
  ```

  Contents of `header.html`:
  ``` jinja2
    <header>
      <h1>Page title</h1>
    </header>
  ```

  Contents of `menu.html`:
  ``` jinja2
    <aside>
      <ul>
        <li><a href="/">Home</a></li>
        <li><a href="/news">News</a></li>
      </ul>
    </aside>
  ```

  Contents of `footer.html`:
  ``` jinja2
    <footer>
      <h1>Page extra text</h1>
    </footer>
  ```

  Result:
  ``` jinja2
    <!DOCTYPE html>
    <html>
    <head>
      <meta charset="utf-8">
      <meta name="viewport" content="width=device-width, initial-scale=1">
      <title>Page title</title>
    </head>
    <body>

      <header>
        <h1>Page title</h1>
      </header>

      <aside>
        <ul>
          <li><a href="/">Home</a></li>
          <li><a href="/news">News</a></li>
        </ul>
      </aside>

      <main>
        {% block content %}{% endblock %}
      </main>

      <footer>
        <h1>Page extra text</h1>
      </footer>

    </body>
    </html>
  ```




Expressions - Expressions of Python programming language can be used inside Jinja2 template
Literals:
- Strings     - `"string"`, `'some text'`
- Integers    - `6`, `20`, `240`, `5437`, `10000000`
- Floats      - `3.14`, `5.25`, `1.44`
- List        - `['a', 'b', 'c']`
- Tuple       - `('a', 'b', 'c')`
- Dictionary  - `{"name": "John", "surname": "Doe"}`
- Boolean     - `true / false`

Math:
- `+`, `-`, `*`, `/`  - Main arithmetic operations (addition, subtraction, multiplication, division)
- `**`                - Power (`{{ 2 ** 3 }}`, result is 8)
- `//`                - Floor (`{{ 20 // 7 }}`, result is 2)
- `%`                 - Modulo (`{{ 11 % 7 }}`, result is 4)

Comparison:
- `==`  - Check if values equal
- `!=`  - Check if values not equal
- `>`   - Check if left hand value is great than right hand value
- `>=`  - Check if left hand value is great than or equal to right hand value
- `<`   - Check if left hand value is less than right hand value
- `<=`  - Check if left hand value is less than or equal to right hand value

Logic:
- `and`     - Logical and operator
- `or`      - Logical or operator
- `not`     - Logical not operator
- `(...)`   - Expression grouping

Other:
- `in`        - Check if left hand value is in of right hand operator
- `is`        - Perform a test
- `|`         - Apply filter
- `~`         - Convert left and right hand values and merge / concatenate values and return resulting string
- `foo()`     - Call function
- `.`, `[]`   - Get field / attribute of object

