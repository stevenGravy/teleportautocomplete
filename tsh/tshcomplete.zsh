_tsh() {
    local line state

    _arguments -s \
               "--proxy[SSH proxy address]:string:" \
                    "-l[Remote host login]:string:" \
                    "--login[Remote host login]:string:" \
                    "--user[SSH proxy user]:string:" \
                    "--ttl[Minutes to live for a SSH session]:string:" \
                    "--identity[Identity file]:filename:_files" \
                    "-i[Identity file]:filename:_files" \
                    "--cert-format[SSH certificate format]:string:" \
                    "--insecure[Do not verify server's certificate and host name. Use only in test environments]" \
                    "--auth[Specify the type of authentication connector to use.]:baseuri:_urls" \
                    "--skip-version-check[Skip version checking between server and client.]" \
                    "--debug[Verbose logging to stdout]" \
                    "-d[Verbose logging to stdout]" \
                    "--add-keys-to-agent[Controls how keys are handled. Valid values are \[auto no yes only\].]:string:" \
                    "-k[Controls how keys are handled. Valid values are .\[auto no yes only\].]:string:" \
                    "--enable-escape-sequences[Enable support for SSH escape sequences. Type '~?' during an SSH session to list supported sequences. Default is enabled.]" \
                    "--bind-addr[Override host:port used when opening a browser for cluster logins]:string:" \
                    "--jumphost[SSH jumphost]" \
                    "-J[SSH jumphost]" \
               "1: :->cmds" \
               "*::arg:->args"

    case "$state" in
        cmds)
            _values "tsh" \
                    "help[Show help]" \
                    "version[Print the version]" \
                    "login[Log in to a cluster and retrieve the session certificate]" \
                    "logout[Delete a cluster certificate]" \
                    "ls[list servers]" \
                    "ssh[Run shell or execute a command on a remote SSH node]" \
                    "db[database functions]" \
                    "join[Join the active SSH session]" \
                    "play[Replay the recorded SSH session]" \
                    "aws[Access AWS API]" \
                    "apps[Application functions ls login logout config]" \
                    "app[Application functions ls login logout config]" \
                    "proxy[Local proxy for ssh or db]" \
                    "scp[Secure file copy]" \
                    "status[Display the list of proxy servers and retrieved certificates]" \
                    "env[Print commands to set Teleport session environment variables]" \
                    "request[Access Request functions]" \
                    "requests[Access Request functions]" \
                    "kube[Kubernetes functions]" \
                    "mfa[MFA functions]" \
                    "config[Print OpenSSH configuration details]" \
            ;;
        args)
            case $line[1] in
                ls)
                    _ls_tsh_cmd
                    ;;
                ssh)
                    _ssh_tsh_cmd
                    ;;
                db)
                    _db_tsh_cmd
                    ;;
                login)
                   _login_tsh_cmd
                    ;;
                apps)
                   _apps_tsh_cmd
                    ;;
                app)
                   _apps_tsh_cmd
                    ;;
                kube)
                   _kube_tsh_cmd
                    ;;
                proxy)
                   _proxy_tsh_cmd
                    ;;
                mfa)
                   _mfa_tsh_cmd
                    ;;
                requests)
                   _requests_tsh_cmd
                    ;;
                request)
                   _requests_tsh_cmd
                    ;;
                scp)
                   _scp_tsh_cmd
                    ;;
# will need to make one that doesn't fail on arguments
                help)
                   _tsh
                    ;;
            esac
            ;;
    esac
}

_scp_tsh_cmd() {
    local line state

    _arguments -s \
  "-r[Recursive copy of subdirectories]" \
  "--recursive[Recursive copy of subdirectories]" \
  "-P[Port to connect to on the remote host]" \
  "--port[Port to connect to on the remote host]" \
  "-p[Preserves access and modification times from the original file]" \
  "--preserve[Preserves access and modification times from the original file]" \
  "-q[Quiet mode]" \
  "--quiet[Quiet mode]"
}

_login_tsh_cmd() {
  _arguments -s "(--login)--login[Remote host login]:string:" \
             "(--proxy)--proxy[SSH proxy address]:string:" \
             "--user[SSH proxy user]:string:" \
             "--ttl[Minutes to live for a SSH session]:string:" \
             "-i[Identity file]:filename:_files" \
             "--identity[Identity file]:filename:_files" \
             "--cert-format[SSH certificate format]:string:" \
             "--insecure[Do not verify server's certificate and host name. Use only in test environments]" \
             "--auth[Specify the type of authentication connector to use.]:string:" \
             "--skip-version-check[Skip version checking between server and client.]" \
             "--debug[Verbose logging to stdout]" \
             "-d[Verbose logging to stdout]" \
             "-k[Controls how keys are handled. Valid values are \[auto no yes only\].]:string:" \
             "--add-keys-to-agent[Controls how keys are handled. Valid values are \[auto no yes only\].]:string:" \
             "--enable-escape-sequences[Enable support for SSH escape sequences. Type '~?' during an SSH session to list supported sequences. Default is enabled.]" \
             "--bind-addr[Override host:port used when opening a browser for cluster logins]:string:" \
             "--jumphost[SSH jumphost]:string:" \
             "-J[SSH jumphost]:string:" \
             "-o[Identity output]:filename:_files" \
             "--out[Identity output]:filename:_files" \
             "--format[Identity format: file, openssh (for OpenSSH compatibility) or kubernetes (for kubeconfig)]:string:" \
             "--overwrite[Whether to overwrite the existing identity file.]" \
             "--request-roles[Request one or more extra roles]:string:" \
             "--request-reason[Reason for requesting additional roles]:string:" \
             "--request-reviewers[Suggested reviewers for role request]:string:" \
             "--request-nowait[Finish without waiting for request resolution]:string:" \
             "--request-id[Login with the roles requested in the given request]:string:" \
             "--browser[Set to none to suppress browser opening on login]:string:" \
             "--kube-cluster[Name of the Kubernetes cluster to login to]:string:"
}

_requests_tsh_cmd() {
    local line state

    _arguments -C \
               "1: :->cmds" \
               "*::arg:->args"

    case "$state" in
        cmds)
            _values "requests" \
                    "ls[List access requests]" \
                    "list[List access requests]" \
                    "show[Show request details]" \
                    "details[Show request details]" \
                    "new[Create a new access request]" \
                    "create[Create a new access request]" \
                    "review[Review an access request]"
            ;;
        args)
            case $line[1] in
                new)
                    _new_requests_tsh_cmd
                    ;;
                create)
                    _new_requests_tsh_cmd
                    ;;
                review)
                    _review_requests_tsh_cmd
                    ;;
            esac
            ;;
    esac
}

_new_requests_tsh_cmd() {
    local line state

    _arguments -s \
               "--roles[Roles to be requested]:string:" \
      "--reason[Reason for requesting]:string:" \
      "--reviewers[Suggested reviewers]:string:" \
      "--nowait[Finish without waiting for request resolution]"
}

_review_requests_tsh_cmd() {
    local line state

    _arguments -s \
             "--approve[Review proposes approval]" \
             "--deny[Review proposes denial]" \
             "--reason[Review reason message]:string:"
}

_mfa_tsh_cmd() {
    local line state

    _arguments -C \
               "1: :->cmds"

    case "$state" in
        cmds)
            _values "mfa" \
                "ls[Get a list of registered MFA devices]" \
                "add[Add a new MFA device]" \
                "rm[Remove a MFA device]"
            ;;
    esac

}

_proxy_tsh_cmd() {
    local line state

    _arguments -C \
               "1: :->cmds"

    case "$state" in
        cmds)
            _values "proxy" \
                "ssh[Start local TLS proxy for ssh connections when using Teleport in single\-port mode]" \
                "db[Start local TLS proxy for database connections when using Teleport in single\-port mode]"
            ;;
    esac

}

_kube_tsh_cmd() {
    local line state

    _arguments -C \
               "1: :->cmds" 

    case "$state" in
        cmds)
            _values "kube" \
                    "ls[Get a list of kubernetes clusters]" \
                    "login[Login to a kubernetes cluster]" 
            ;;
    esac
}

_apps_tsh_cmd() {
    local line state

    _arguments -C \
               "1: :->cmds" \
               "*::arg:->args"

    case "$state" in
        cmds)
            _values "apps" \
                    "ls[List available applications]" \
                    "login[Retrieve short-lived certificate for an app.]" \
                    "logout[Remove app certificate.]" \
                    "config[Print app connection information.]"
            ;;
        args)
            case $line[1] in
                login)
                    _apps_login_tsh_cmd
                    ;;
            esac
            ;;
    esac
}

_apps_login_tsh_cmd() {
    _arguments -s \
               '--aws-role[(For AWS CLI access only) Amazon IAM role ARN or role name.]:string:'
}

_db_tsh_cmd() {
    local line state

    _arguments -C \
               "1: :->cmds" \
               "*::arg:->args"

    case "$state" in
        cmds)
            _values "db" \
                    "ls[List all available databases]" \
                    "login[Retrieve credentials for a database.]" \
                    "logout[Remove database credentials]" \
                    "env[Print environment variables for the configured database.]" \
                    "config[Print database connection information. Useful when configuring GUI clients.]" \
                    "connect[Connect to a database.]" 
            ;;
        args)
            case $line[1] in
                ls)
                    _db_ls_tsh_cmd
                    ;;
                login)
                    _db_login_tsh_cmd
                    ;;
                env)
                    _db_env_tsh_cmd
                    ;;
                config)
                    _db_config_tsh_cmd
                    ;;
                connect)
                    _db_login_tsh_cmd
                    ;;
            esac
            ;;
    esac
}

_db_config_tsh_cmd() {
    _arguments -s \
               '--format[Print format: \"text\" to print in table format (default),  \"cmd\"  to print connect command.]'
}

_db_ls_tsh_cmd() {
}

_db_login_tsh_cmd() {
    _arguments -s \
               "--db-user[Optional database user to configure as default]:string:" \
                    "--db-name[Optional database name to configure as default.]:string:" \
     "*: :( $(tsh db ls | sed -n '3,$p' | awk '{print $1}') )"
}


_ls_tsh_cmd() {
}

_ssh_tsh_cmd() {
  local line state
    _arguments -s \
               "1: :->cmds" \
               "*::arg:->args"

    case "$state" in
        cmds)
            _values "ssh" \
             "--login[Remote host login]" \
             "--proxy[SSH proxy address]" \
             "--user[SSH proxy user]" \
             "--ttl[Minutes to live for a SSH session]" \
             "-i[Identity file]" \
             "--identity[Identity file]" \
             "--cert-format[SSH certificate format]" \
             "--insecure[Do not verify server's certificate and host name. Use only in test environments]" \
             "--auth[Specify the type of authentication connector to use.]" \
             "--skip-version-check[Skip version checking between server and client.]" \
             "--debug[Verbose logging to stdout]" \
             "-d[Verbose logging to stdout]"
            ;;
        args)
            case $line[2] in
                -i)
                    _identity_tsh_cmd
                    ;;
            esac
            ;;
    esac
}

_identity_tsh_cmd() {
  _arguments '*:files:_files'
}

compdef _tsh tsh
