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
                    "request[Manage access requests]" \
                    "apps[Operate on applications registered with the cluster.]" \
                    "db[Operate on databases registered with the cluster.]" \
                    "kube[Operate on registered kubernetes clusters.]" \
                    "bots[Operate on certificate renewal bots registered with the cluster.]" \
                    "inventory[Manage Teleport instance inventory]" \
                    "lock[Create a new lock.]" \
                    "sso[A family of commands for configuring and testing auth connectors (SSO).]" \
                    "saml[Export a SAML signing key in .crt format]" \
                    "version[Print cluster version]"
            ;;
        args)
            case $line[1] in
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
                kube)
                   _kube_tctl_cmd
                    ;;
                lock)
                   _lock_tctl_cmd
                    ;;
                request)
                   _requests_tctl_cmd
                    ;;
                create)
                   _create_tctl_cmd
                    ;;
                requests)
                   _requests_tctl_cmd
                    ;;
                bots)
                   _bots_tctl_cmd
                    ;;
                inventory)
                   _inventory_tctl_cmd
                    ;;
                saml)
                   _saml_tctl_cmd
                    ;;
                sso)
                   _sso_tctl_cmd
                    ;;
                help)
                   _tctl
                    ;;
            esac
            ;;
    esac
}

_sso_tctl_cmd(){


    helpauth=$(tctl help sso 2>&1 | grep "sso")

    _arguments -s \
               "1: :->cmds" \
               "*::arg:->args"

    case "$state" in
        cmds)
            _values "sso" \
                    "configure[Create auth connector configuration.]" \
                    "test[$(echo "$helpauth" | grep "sso test" | sed -n -e 's/^.*sso test//p'|sed -e 's/^[ \t]*//')]"
            ;;
        args)
            case $line[1] in
                configure)
                    _configure_sso_tctl_cmd
                    ;;
                test)
                    _test_sso_tctl_cmd
                    ;;
            esac
            ;;
    esac
}

_test_sso_tctl_cmd(){

    _arguments -s \
   "1:filename:_files"
}

_configure_sso_tctl_cmd(){


    helpauth=$(tctl help sso configure 2>&1 | grep "sso configure ")

    _arguments -s \
               "1: :->cmds" \
               "*::arg:->args"

    case "$state" in
        cmds)
            _values "configure" \
                    "github[$(echo "$helpauth" | grep "configure github" | sed -n -e 's/^.*configure github//p'|sed -e 's/^[ \t]*//')]" \
                    "gh[$(echo "$helpauth" | grep "configure github" | sed -n -e 's/^.*configure github//p'|sed -e 's/^[ \t]*//')]" \
                    "saml[$(echo "$helpauth" | grep "configure saml" | sed '1,/inventory status/s/inventory status//' |sed -e 's/^[ \t]*//'|sed 's/[[]/(/g' | sed 's/[]]/)/g')]" \
                    "oidc[$(echo "$helpauth" | grep "configure oidc" | sed -n -e 's/^.*configure oidc//p'|sed -e 's/^[ \t]*//')]" \
            ;;
        args)
            case $line[1] in
                github)
                    _github_configure_sso_tctl_cmd
                    ;;
                saml)
                    _saml_configure_sso_tctl_cmd
                    ;;
                oidc)
                    _oidc_configure_sso_tctl_cmd
                    ;;
            esac
            ;;
    esac
}

_github_configure_sso_tctl_cmd(){

    _arguments -s \
   "--name[Connector name.]:string:"  \
   "-n[Connector name.]:string:"  \
   "--teams-to-roles[Sets teams-to-roles mapping using format 'organization,name,role1,role2,...'. Repeatable.]:string:" \
   "--display[Sets the connector display name.]:string:"  \
   "--id[GitHub app client ID.]:string:"  \
   "--secret[GitHub app client secret.]:string:"  \
   "--redirect-url[Authorization callback URL.]:string:"  \
   "--ignore-missing-roles[Ignore missing roles referenced in --teams-to-roles]" 
}

_oidc_configure_sso_tctl_cmd(){
    
    _arguments -s \
   "-p[Preset. One of: (okta onelogin ad adfs)]:string:"  \
   "--preset[Preset. One of: (okta onelogin ad adfs)]:string:" \
   "-n[Connector name. Required, unless implied from preset.]:string:"  \
   "--name[Connector name. Required, unless implied from preset.]:string:" \
   "-r[Sets claim-to-roles mapping using format 'claim_name,claim_value,role1,role2,...'. Repeatable.]:string:" \
   "--claims-to-roles[Sets claim-to-roles mapping using format 'claim_name,claim_value,role1,role2,...'. Repeatable.]:string:" \
   "--display[Sets the connector display name.]:string:" \
   "--id[OIDC app client ID.]:string:" \
   "--secret[OIDC app client secret.]:string:" \
   "--issuer-url[Issuer URL.]:string:" \
   "--redirect-url[Authorization callback URL(s). Each repetition of the flag declares one redirectURL.]:string:" \
   "--prompt[Optional OIDC prompt. Example values: none, select_account, login, consent.]:string:" \
   "--scope[Scope specifies additional scopes set by provider. Each repetition of the flag declares one scope. Examples: email, groups, openid.]:string:" \
   "--acr[Authentication Context Class Reference values.]:string:" \
   "--provider[Sets the external identity provider type to enable IdP specific workarounds. Examples: ping, adfs, netiq, okta.]:string:" \
   "--google-acc-uri[Google only. URI pointing at service account credentials. Example: file:///var/lib/teleport/gworkspace-creds.json.]:string:" \
   "--google-acc[Google only. String containing Google service account credentials.]:string:" \
   "--google-admin[Google only. String containing Google service account credentials.]:string:" \
   "--google-legacy[Google only. Flag to select groups with direct membership filtered by domain (legacy behavior). Disabled by default.]" \
   "--google-id[Google only. Flag to select groups with direct membership filtered by domain (legacy behavior). Disabled by default.]:string:" \
   "--ignore-missing-roles[Ignore missing roles referenced in --claims-to-roles.]"

}

_saml_configure_sso_tctl_cmd(){

    _arguments -s \
   "-p[Preset. One of: (okta onelogin ad adfs)]:string:"  \
   "--preset[Preset. One of: (okta onelogin ad adfs)]:string:" \
   "-n[Connector name. Required, unless implied from preset.]:string:"  \
   "--name[Connector name. Required, unless implied from preset.]:string:" \
   "-e[Set the Entity Descriptor. Valid values: file, URL, XML content. Supplies configuration parameters as single XML instead of individual elements.]:string:"  \
   "--entity-descriptor[Set the Entity Descriptor. Valid values: file, URL, XML content. Supplies configuration parameters as single XML instead of individual elements.]:string:"  \
   "-r[Sets attribute-to-role mapping using format 'attr_name,attr_value,role1,role2,...'. Repeatable.]:string:"  \
   "--attributes-to-roles[Sets attribute-to-role mapping using format 'attr_name,attr_value,role1,role2,...'. Repeatable.]:string:" \
   "--display[Sets the connector display name.]:string:"  \
   "--issuer[Issuer is the identity provider issuer.]:string:"  \
   "--sso[SSO is the URL of the identity provider's SSO service.]:string:"  \
   "--cert[Cert file with with the IdP certificate PEM. IdP signs <Response> responses using this certificate.]:filename:_files"  \
   "--acs[AssertionConsumerService is a URL for assertion consumer service on the service provider (Teleport's side).]:string:"  \
   "--audience[Audience uniquely identifies our service provider.]:string:"  \
   "--service-provider-issuer[ServiceProviderIssuer is the issuer of the service provider (Teleport).]:string:"  \
   "--signing-key-file[A file with request signing key. Must be used together with --signing-cert-file.]:filename:_files"  \
   "--signing-cert-file[A file with request certificate. Must be used together with --signing-key-file.]:filename:_files"  \
   "--assertion-key-file[A file with key used for securing SAML assertions. Must be used together with --assertion-cert-file.]:filename:_files"  \
   "--assertion-cert-file[A file with cert used for securing SAML assertions. Must be used together with --assertion-key-file.]:filename:_files"  \
   "--provider[Sets the external identity provider type. Examples: ping, adfs.]:string:"  \
   "--ignore-missing-roles[Ignore missing roles referenced in --attributes-to-roles.]"
}

_kube_tctl_cmd(){

    helpauth=$(tctl help kube 2>&1 | grep "kube")

    _arguments -s \
               "1: :->cmds" \
               "*::arg:->args"

    case "$state" in
        cmds)
            _values "kube" \
                    "ls[$(echo "$helpauth" | grep "kube ls" | sed -n -e 's/^.*kube ls//p'|sed -e 's/^[ \t]*//')]"
            ;;
    esac
}

_saml_tctl_cmd(){


    helpauth=$(tctl help saml 2>&1 | grep "saml")

    _arguments -s \
               "1: :->cmds" \
               "*::arg:->args"

    case "$state" in
        cmds)
            _values "saml" \
                    "export[$(echo "$helpauth" | grep "saml export" | sed -n -e 's/^.*saml export//p'|sed -e 's/^[ \t]*//')]"
            ;;
    esac
}


_inventory_tctl_cmd(){


    helpauth=$(tctl help inventory 2>&1 | grep "inventory")

    _arguments -s \
               "1: :->cmds" \
               "*::arg:->args"

    case "$state" in
        cmds)
            _values "inventory" \
                    "status[Show inventory status summary]" \
                    "ping[$(echo "$helpauth" | grep "inventory ping" | sed -n -e 's/^.*inventory ping//p'|sed -e 's/^[ \t]*//')]"
            ;;
        args)
            case $line[1] in
                status)
                    _status_inventory_tctl_cmd
                    ;;
            esac
            ;;
    esac
}

_status_inventory_tctl_cmd(){

    _arguments -s \
   "--connected[Show locally connected instances summary]"
}

_create_tctl_cmd(){


   forceMsg=$(echo "Overwrite the resource if already exists")
    _arguments -s \
   "-f[$(echo $forceMsg)]" \
   "--force[$(echo $forceMsg)]" \
   "1:filename:_files"
}


_list_requestid_tctl_cmd()
 {
  _arguments "*: :( $(tctl requests ls | sed -n '3,$p' | awk '{print $1}') )"
}

_bots_tctl_cmd(){


    helpauth=$(tctl help bots 2>&1 | grep "bots")

    _arguments -s \
               "1: :->cmds" \
               "*::arg:->args"

    case "$state" in
        cmds)
            _values "bots" \
                    "ls[$(echo "$helpauth" | grep "bots ls" | sed -n -e 's/^.*bots ls//p'|sed -e 's/^[ \t]*//')]" \
                    "add[$(echo "$helpauth" | grep "bots add" | sed -n -e 's/^.*bots add//p'|sed -e 's/^[ \t]*//')]" \
                    "rm[$(echo "$helpauth" | grep "bots rm" | sed -n -e 's/^.*bots rm//p'|sed -e 's/^[ \t]*//')]"
            ;;
        args)
            case $line[1] in
                add)
                    _add_bots_tctl_cmd
                    ;;
                rm)
                    _rm_bots_tctl_cmd
                    ;;
            esac
            ;;
    esac
}

_add_bots_tctl_cmd(){
    helpauth=$(tctl help bots add 2>&1 | grep "\-\-")

    _arguments -s \
  "--roles[$(echo "$helpauth" | grep "  \-\-roles" | sed -n -e 's/^.*\-\-roles//p'|sed -e 's/^[ \t]*//')]:string:" \
  "--ttl[$(echo "$helpauth" | grep "  \-\-ttl" | sed -n -e 's/^.*\-\-ttl//p'|sed -e 's/^[ \t]*//')]:string:" \
  "--token[$(echo "$helpauth" | grep "  \-\-token" | sed -n -e 's/^.*\-\-token//p'|sed -e 's/^[ \t]*//')]:string:"

}

_rm_bots_tctl_cmd(){
    helpauth=$(tctl help bots rm 2>&1 | grep "\-\-")

    _arguments -s \
               "1: :_list_bots_tctl_cmd"

}

_list_bots_tctl_cmd()
 {
  _arguments "*: :( $(tctl bots ls | sed -n '3,$p' | awk '{print $1}') )"
}


_requests_tctl_cmd(){


    helpauth=$(tctl help requests 2>&1 | grep "requests")

    _arguments -s \
               "1: :->cmds" \
               "*::arg:->args"

    case "$state" in
        cmds)
            _values "requests" \
                    "ls[$(echo "$helpauth" | grep "requests ls" | sed -n -e 's/^.*requests ls//p'|sed -e 's/^[ \t]*//')]" \
                    "get[$(echo "$helpauth" | grep "requests get" | sed -n -e 's/^.*requests get//p'|sed -e 's/^[ \t]*//')]" \
                    "approve[$(echo "$helpauth" | grep "requests approve" | sed -n -e 's/^.*requests approve//p'|sed -e 's/^[ \t]*//')]" \
                    "deny[$(echo "$helpauth" | grep "requests deny" | sed -n -e 's/^.*requests deny//p'|sed -e 's/^[ \t]*//')]" \
                    "create[$(echo "$helpauth" | grep "requests create" | sed -n -e 's/^.*requests create//p'|sed -e 's/^[ \t]*//')]" \
                    "rm[$(echo "$helpauth" | grep "requests rm" | sed -n -e 's/^.*requests rm//p'|sed -e 's/^[ \t]*//')]" \
                    "review[$(echo "$helpauth" | grep "requests review" | sed -n -e 's/^.*requests review//p'|sed -e 's/^[ \t]*//')]"
            ;;
        args)
            case $line[1] in
                approve)
                    _approve_requests_tctl_cmd
                    ;;
                deny)
                    _deny_requests_tctl_cmd
                    ;;
                create)
                    _create_requests_tctl_cmd
                    ;;
                review)
                    _review_requests_tctl_cmd
                    ;;
                get)
                    _list_requestid_tctl_cmd
                    ;;
                rm)
                    _list_requestid_tctl_cmd
                    ;;
            esac
            ;;
    esac
}

_review_requests_tctl_cmd(){
    helpauth=$(tctl help requests review 2>&1 | grep "\-\-")

    _arguments -s \
  "--author[$(echo "$helpauth" | grep "  \-\-author" | sed -n -e 's/^.*\-\-author//p'|sed -e 's/^[ \t]*//')]:string:" \
  "--approve[$(echo "$helpauth" | grep "\-\-approve" | sed -n -e 's/^.*\-\-approve//p'|sed -e 's/^[ \t]*//')]" \
  "--deny[$(echo "$helpauth" | grep "\-\-deny" | sed -n -e 's/^.*\-\-deny//p'|sed -e 's/^[ \t]*//')]" \
               "1: :_list_requestid_tctl_cmd"

}

_approve_requests_tctl_cmd(){
    helpauth=$(tctl help requests approve 2>&1 | grep "\-\-")

    _arguments -s \
  "--delegator[$(echo "$helpauth" | grep "\-\-delegator" | sed -n -e 's/^.*\-\-delegator//p'|sed -e 's/^[ \t]*//')]:string:" \
  "--reason[$(echo "$helpauth" | grep "\-\-reason" | sed -n -e 's/^.*\-\-reason//p'|sed -e 's/^[ \t]*//')]:string:" \
  "--annotations[Resolution attributes key=value]:string:" \
  "--roles[Overide request roles]:string:" \
               "1: :_list_requestid_tctl_cmd" 

}

_deny_requests_tctl_cmd(){
    helpauth=$(tctl help requests deny 2>&1 | grep "\-\-")

    _arguments -s \
  "--delegator[$(echo "$helpauth" | grep "\-\-delegator" | sed -n -e 's/^.*\-\-delegator//p'|sed -e 's/^[ \t]*//')]:string:" \
  "--reason[$(echo "$helpauth" | grep "\-\-reason" | sed -n -e 's/^.*\-\-reason//p'|sed -e 's/^[ \t]*//')]:string:" \
  "--annotations[Resolution attributes key=value]:string:" \
  "--roles[Overide request roles]:string:" \
               "1: :_list_requestid_tctl_cmd"

}

_create_requests_tctl_cmd(){
    helpauth=$(tctl help requests create 2>&1 | grep "\-\-")

    _arguments -s \
  "--roles[$(echo "$helpauth" | grep "\-\-roles" | sed -n -e 's/^.*\-\-roles//p'|sed -e 's/^[ \t]*//')]:string:" \
  "--reason[$(echo "$helpauth" | grep "\-\-reason" | sed -n -e 's/^.*\-\-reason//p'|sed -e 's/^[ \t]*//')]:string:" \
  "--dry-run[$(echo "$helpauth" | grep "\-\-dry\-run" | sed -n -e 's/^.*\-\-dry\-run//p'|sed -e 's/^[ \t]*//')]" \
               "1: :_list_users_tctl_cmd"

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
  "--ttl[$(echo "$helpauth" | grep "\-\-ttl" | sed -n -e 's/^.*\-\-ttl//p'|sed -e 's/^[ \t]*//')]:string:"
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
      "--node[Teleport node]:string:" 
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
