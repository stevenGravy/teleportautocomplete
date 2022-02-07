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
                users)
                    _users_tctl_cmd
                    ;;
                nodes)
                    _nodes_tctl_cmd
                    ;;
                help)
                   _tctl
                    ;;
            esac
            ;;
    esac
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
