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
# will need to make one that doesn't fail on arguments
                help)
                   _tctl
                    ;;
            esac
            ;;
    esac
}

compdef _tctl tctl
