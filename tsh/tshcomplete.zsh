_tsh() {
    local line state

    _arguments -s \
               "--proxy[SSH proxy address]" \
                    "-l[Remote host login]" \
                    "--login[Remote host login]" \
                    "--user[SSH proxy user]" \
                    "--ttl[Minutes to live for a SSH session]" \
                    "--identity[Identity file]" \
                    "-i[Identity file]" \
                    "--cert-format[SSH certificate format]" \
                    "--insecure[Do not verify server's certificate and host name. Use only in test environments]" \
                    "--auth[Specify the type of authentication connector to use.]" \
                    "--skip-version-check[Skip version checking between server and client.]" \
                    "--debug[Verbose logging to stdout]" \
                    "-d[Verbose logging to stdout]" \
                    "--add-keys-to-agent[Controls how keys are handled. Valid values are \[auto no yes only\].]" \
                    "-k[Controls how keys are handled. Valid values are .\[auto no yes only\].]" \
                    "--enable-escape-sequences[Enable support for SSH escape sequences. Type '~?' during an SSH session to list supported sequences. Default is enabled.]" \
                    "--bind-addr[Override host:port used when opening a browser for cluster logins]" \
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
                    "proxy[Local proxy for ssh or db]" \
                    "scp[Secure file copy]" \
                    "status[Display the list of proxy servers and retrieved certificates]" \
                    "env[Print commands to set Teleport session environment variables]" \
                    "request[Access Request functions]" \
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
            esac
            ;;
    esac
}

_login_tsh_cmd() {
  _arguments "--login[Remote host login]" \
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
             "-d[Verbose logging to stdout]" \
             "-k[Controls how keys are handled. Valid values are \[auto no yes only\].]" \
             "--add-keys-to-agent[Controls how keys are handled. Valid values are \[auto no yes only\].]" \
             "--enable-escape-sequences[Enable support for SSH escape sequences. Type '~?' during an SSH session to list supported sequences. Default is enabled.]" \
             "--bind-addr[Override host:port used when opening a browser for cluster logins]" \
             "--jumphost[SSH jumphost]" \
             "-J[SSH jumphost]" \
             "-o[Identity output]" \
             "--out[Identity output]" \
             "--format[Identity format: file, openssh (for OpenSSH compatibility) or kubernetes (for kubeconfig)]" \
             "--overwrite[Whether to overwrite the existing identity file.]" \
             "--request-roles[Request one or more extra roles]" \
             "--request-reason[Reason for requesting additional roles]" \
             "--request-reviewers[Suggested reviewers for role request]" \
             "--request-nowait[Finish without waiting for request resolution]" \
             "--request-id[Login with the roles requested in the given request]" \
             "--browser[Set to none to suppress browser opening on login]" \
             "--kube-cluster[Name of the Kubernetes cluster to login to]"
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
               "--db-user[Optional database user to configure as default]" \
                    "--db-name[Optional database name to configure as default.]" \
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
