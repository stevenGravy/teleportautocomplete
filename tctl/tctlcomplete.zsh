_tctl() {
    local line state

    _arguments -s \
   "-d[Enable verbose logging to stderr]" \
   "--debug[Enable verbose logging to stderr]" \
  "-c[Path to a configuration file \[/etc/teleport.yaml\]. Can also be set via the TELEPORT_CONFIG_FILE environment variable.]:filename:_files" \
  "--config[Path to a configuration file \[/etc/teleport.yaml\]. Can also be set via the TELEPORT_CONFIG_FILE environment variable.]:filename:_files" \
  "--auth-server[Attempts to connect to specific auth/proxy address(es) instead of local auth \[127.0.0.1:3025\]]:baseuri:_urls" \
  "-i[Path to an identity file. Must be provided to make remote connections to auth. An identity file can be exported with \'tctl auth sign\']:filename:_files" \
  "--identity[Path to an identity file. Must be provided to make remote connections to auth. An identity file can be exported with \'tctl auth sign\']:filename:_files" \
  "--insecure[When specifying a proxy address in do not verify its TLS certificate]" \
               "1: :->cmds" \
               "*::arg:->args"

    case "$state" in
        cmds)
            _values "tctl" \
                    "help[Show help.]" \
                    "users[Manage user accounts]" \
                    "nodes[Issue invites for other nodes to join the cluster]" \
                    "tokens[List or revoke invitation tokens]" \
                    "auth[Operations with user and host certificate authorities (CAs)]" \
                    "create[Create or update a Teleport resource from a YAML file]" \
                    "update[Update resource fields]" \
                    "rm[Delete a resource]" \
                    "status[Report cluster status]" \
                    "top[Report diagnostic information]" \
                    "requests[Manage access requests]" \
                    "apps[Operate on applications registered with the cluster.]" \
                    "db[Operate on databases registered with the cluster.]" \
                    "access[Get access information within the cluster.]" \
                    "lock[Create a new lock.]" \
                    "version[Print cluster version]" \
            ;;
        args)
            case $line[1] in
                access)
                    _access_tctl_cmd
                    ;;
                users)
                    _users_tctl_cmd
                    ;;
                nodes)
                    _nodes_tctl_cmd
                    ;;
                tokens)
                    _tokens_tctl_cmd
                    ;;
                auth)
                   _auth_tctl_cmd
                    ;;
                apps)
                   _apps_tctl_cmd
                    ;;
                db)
                   _db_tctl_cmd
                    ;;
                lock)
                   _lock_tctl_cmd
                    ;;
                help)
                   _tctl
                    ;;
            esac
            ;;
    esac
}

_db_tctl_cmd(){

    helpauth=$(tctl help db 2>&1 | grep "db")

    _arguments -s \
               "1: :->cmds"

    case "$state" in
        cmds)
            _values "db" \
                    "ls[$(echo "$helpauth" | grep "db ls" | sed -n -e 's/^.*db ls//p'|sed -e 's/^[ \t]*//')]" \
            ;;
    esac
}

_apps_tctl_cmd(){

    helpauth=$(tctl help apps 2>&1 | grep "apps")

    _arguments -s \
               "1: :->cmds" 

    case "$state" in
        cmds)
            _values "apps" \
                    "ls[$(echo "$helpauth" | grep "apps ls" | sed -n -e 's/^.*apps ls//p'|sed -e 's/^[ \t]*//')]" \
            ;;
    esac
}

_lock_tctl_cmd(){
    helpauth=$(tctl help lock 2>&1 | grep "\-\-")
  _arguments -s \
  "--user[$(echo "$helpauth" | grep "\-\-user" | sed -n -e 's/^.*\-\-user//p'|sed -e 's/^[ \t]*//')]:string:" \
  "--role[$(echo "$helpauth" | grep "\-\-role" | sed -n -e 's/^.*\-\-role//p'|sed -e 's/^[ \t]*//')]:string:" \
  "--login[$(echo "$helpauth" | grep "\-\-login" | sed -n -e 's/^.*\-\-login//p'|sed -e 's/^[ \t]*//')]:string:" \
  "--node[$(echo "$helpauth" | grep "\-\-node" | sed -n -e 's/^.*\-\-node//p'|sed -e 's/^[ \t]*//')]:string:" \
  "--mfa-device[$(echo "$helpauth" | grep "\-\-mfa\-device" | sed -n -e 's/^.*\-\-mfa\-device//p'|sed -e 's/^[ \t]*//')]:string:" \
  "--windows-desktop[$(echo "$helpauth" | grep "\-\-windows\-desktop" | sed -n -e 's/^.*\-\-windows\-desktop//p'|sed -e 's/^[ \t]*//')]:string:" \
  "--access-request[$(echo "$helpauth" | grep "\-\-access\-request" | sed -n -e 's/^.*\-\-access\-request//p'|sed -e 's/^[ \t]*//')]:string:" \
  "--message[$(echo "$helpauth" | grep "\-\-message" | sed -n -e 's/^.*\-\-message//p'|sed -e 's/^[ \t]*//')]:string:" \
  "--expires[$(echo "$helpauth" | grep "\-\-expires" | sed -n -e 's/^.*\-\-expires//p'|sed -e 's/^[ \t]*//')]:string:" \
  "--ttl[$(echo "$helpauth" | grep "\-\-ttl" | sed -n -e 's/^.*\-\-ttl//p'|sed -e 's/^[ \t]*//')]:string:" \
}


_auth_tctl_cmd() {
    local line state
    
    helpauth=$(tctl help auth 2>&1 | grep "  auth")

    _arguments -s \
               "1: :->cmds" \
               "*::arg:->args"

    case "$state" in
        cmds)
            _values "auth" \
                    "export[$(echo "$helpauth" | grep "auth export" | sed -n -e 's/^.*export//p'|sed -e 's/^[ \t]*//')]" \
                    "sign[$(echo "$helpauth" | grep "auth sign" | sed -n -e 's/^.*sign//p'|sed -e 's/^[ \t]*//')]" \
                    "rotate[$(echo "$helpauth" | grep "auth rotate" | sed -n -e 's/^.*rotate//p'|sed -e 's/^[ \t]*//')]"
            ;;
        args)
            case $line[1] in
                export)
                    _export_auth_tctl_cmd
                    ;;
                sign)
                    _sign_auth_tctl_cmd
                    ;;
                rotate)
                    _rotate_auth_tctl_cmd
                    ;;
            esac
            ;;
    esac
}

_rotate_auth_tctl_cmd(){
    helpauth=$(tctl help auth rotate 2>&1 | grep "\-\-")
  _arguments -s \
  "--grace-period[$(echo "$helpauth" | grep "\-\-grace\-period" | sed -n -e 's/^.*\-\-grace\-period//p'|sed -e 's/^[ \t]*//')]:string:" \
  "--manual[$(echo "$helpauth" | grep "\-\-manual" | sed -n -e 's/^.*\-\-manual//p'|sed -e 's/^[ \t]*//')]" \
  "--type[$(echo "$helpauth" | grep "\-\-type" | sed -n -e 's/^.*\-\-type//p'|sed -e 's/^[ \t]*//')]" \
  "--phase[$(echo "$helpauth" | grep "\-\-phase" | sed -n -e 's/^.*\-\-phase//p'|sed -e 's/^[ \t]*//')]"
}

_export_auth_tctl_cmd(){
    helpauth=$(tctl help auth export 2>&1 | grep "\-\-")
  _arguments -s \
  "--keys[$(echo "$helpauth" | grep "\-\-keys" | sed -n -e 's/^.*\-\-keys//p'|sed -e 's/^[ \t]*//')]" \
  "--fingerprint[$(echo "$helpauth" | grep "\-\-fingerprint" | sed -n -e 's/^.*\-\-fingerprint//p'|sed -e 's/^[ \t]*//')]" \
  "--compat[$(echo "$helpauth" | grep "\-\-compat" | sed -n -e 's/^.*\-\-compat//p'|sed -e 's/^[ \t]*//')]" \
  "--type[$(echo "$helpauth" | grep "\-\-type" | sed -n -e 's/^.*\-\-type//p'|sed -e 's/^[ \t]*//')]" 
}

_sign_auth_tctl_cmd(){
  _arguments -s \
  "--user[Teleport user name]:string:" \
  "--host[Teleport host name]:string:" \
  "--out[identity output]" \
  "-o[identity output]" \
  "--format[identity format: "file" (default), "openssh", "tls", "kubernetes", "db" or "mongodb"]:string:" \
  "--ttl[TTL (time to live) for the generated certificate]:string:" \
  "--compat[OpenSSH compatibility flag]" \
  "--proxy[Address of the teleport proxy. When --format is set to "kubernetes", this address will be set as cluster address in the generated kubeconfig file]:string:" \
  "--overwrite[Whether to overwrite existing destination files. When not set, user will be prompted before overwriting any existing file.]" \
  "--leaf-cluster[Leaf cluster to generate identity file for when --format is set to "kubernetes"]:string:" \
  "--kube-cluster-name[Kubernetes cluster to generate identity file for when --format is set to "kubernetes"]:string:" \
  "--app-name[Application to generate identity file for]:string:"
}


_tokens_tctl_cmd() {
    local line state

    _arguments -s \
               "1: :->cmds" \
               "*::arg:->args"

    case "$state" in
        cmds)
            _values "tokens" \
                    "add[Create a invitation token]" \
                    "rm[Delete/revoke an invitation token]" \
                    "del[Delete/revoke an invitation token]" \
                    "ls[List node and user invitation tokens]"
            ;;
        args)
            case $line[1] in
                add)
                    _add_tokens_tctl_cmd
                    ;;
            esac
            ;;
    esac

}

_add_tokens_tctl_cmd(){
   _arguments -s \
      "--type[Type of token to add]:string:" \
      "--value[Value of token to add]:string:" \
      "--labels[Set token labels, e.g. env=prod,region=us-west]:string:" \
      "--ttl[Set expiration time for token, default is 1 hour, maximum is 48 hours]:string:" \
      "--app-name[Name of the application to add]:string:" \
      "--app-uri[URI of the application to add]:string:" \
      "--db-name[Name of the database to add]:string:" \
      "--db-protocol[Database protocol to use. Supported are: \[postgres mysql mongodb cockroachdb\]]:string:" \
      "--db-uri[Address the database is reachable at]:string:" 

}

_access_tctl_cmd() {
    local line state

    _arguments -s \
               "1: :->cmds" \
               "*::arg:->args"

    case "$state" in
        cmds)
            _values "access" \
                    "ls[users]"
            ;;
        args)
            case $line[1] in
                ls)
                    _ls_access_tctl_cmd
                    ;;
            esac
            ;;
    esac
}

_ls_access_tctl_cmd() {
    _arguments -s \
      "--user[Teleport user]:string:" \
      "--login[Teleport login]:string:" \
      "--node[Teleport node]:string:" \
}

_nodes_tctl_cmd() {
    local line state

    _arguments -s \
               "1: :->cmds" \
               "*::arg:->args"

    case "$state" in
        cmds)
            _values "nodes" \
                    "add[Generate a node invitation token]" \
                    "ls[List all active SSH nodes within the cluster]"
            ;;
        args)
            case $line[1] in
                add)
                    _add_nodes_tctl_cmd
                    ;;
                ls)
                    _ls_nodes_tctl_cmd
                    ;;
            esac
            ;;
    esac
}

_ls_nodes_tctl_cmd() {
    _arguments -s \
      "--namespace[Namespace of the nodes]:string:"
}

_users_tctl_cmd() {
    local line state

    _arguments -s \
               "1: :->cmds" \
               "*::arg:->args"

    case "$state" in
        cmds)
            _values "users" \
                    "add[Generate a user invitation token \[Teleport DB users only\]]" \
                    "ls[List all user accounts]" \
                    "rm[Deletes user accounts]" \
                    "reset[Reset user password and generate a new token \[Teleport DB users only\]]" \
                    "del[Reset user password and generate a new token \[Teleport DB users only\]]"
            ;;
        args)
            case $line[1] in
                add)
                    _add_users_tctl_cmd
                    ;;
                rm)
                    _list_users_tctl_cmd
                    ;;
                reset)
                    _list_users_tctl_cmd
                    ;;
            esac
            ;;
    esac
}

_list_users_tctl_cmd()
 {
  _arguments "*: :( $(tctl users ls | sed -n '3,$p' | awk '{print $1}') )"
}

_add_users_tctl_cmd() {

    _arguments -s \
      "--logins[List of allowed SSH logins for the new user]:string:" \
      "--windows-logins[List of allowed Windows logins for the new user]:string:" \
      "--roles[List of roles for the new user to assume]:string:" \
      "--ttl[Set expiration time for token, default is 1h0m0s, maximum is 48h0m0s]:string:"
}

compdef _tctl tctl
