#This module contains the general information for DownloadRootCACertificate ManagedObject.

require_relative '../../imcmo'
require_relative '../../imccoremeta'
require_relative '../../imcmeta'


class DownloadRootCACertificateConsts
    PROTOCOL_FTP = "ftp"
    PROTOCOL_HTTP = "http"
    PROTOCOL_NONE = "none"
    PROTOCOL_SCP = "scp"
    PROTOCOL_SFTP = "sftp"
    PROTOCOL_TFTP = "tftp"
end


class DownloadRootCACertificate < ManagedObject
    #This is DownloadRootCACertificate class.

    @@consts = DownloadRootCACertificateConsts.new()
#    @@naming_props = set([])

    @@mo_meta = {
        "classic" => MoMeta.new("DownloadRootCACertificate", "downloadRootCACertificate", "kmip-ca-cert-download", VersionMeta::VERSION302B, "InputOutput", 0x1ff, [], ["admin", "read-only", "user"], [nil]),
    }

    def self.mo_meta
        @@mo_meta
    end

    @@prop_meta = {

        "classic" => {
        "child_action" => MoPropertyMeta.new("child_action", "childAction", "string", VersionMeta::VERSION302B, MoPropertyMeta::INTERNAL, nil, nil, nil, nil, [], []), 
        "dn" => MoPropertyMeta.new("dn", "dn", "string", VersionMeta::VERSION302B, MoPropertyMeta::READ_WRITE, 0x2, 0, 255, nil, [], []), 
        "download_progress" => MoPropertyMeta.new("download_progress", "downloadProgress", "string", VersionMeta::VERSION302B, MoPropertyMeta::READ_ONLY, nil, nil, nil, nil, [], []), 
        "download_status" => MoPropertyMeta.new("download_status", "downloadStatus", "string", VersionMeta::VERSION302B, MoPropertyMeta::READ_ONLY, nil, nil, nil, nil, [], []), 
        "protocol" => MoPropertyMeta.new("protocol", "protocol", "string", VersionMeta::VERSION302B, MoPropertyMeta::READ_WRITE, 0x4, nil, nil, nil, ["ftp", "http", "none", "scp", "sftp", "tftp"], []), 
        "pwd" => MoPropertyMeta.new("pwd", "pwd", "string", VersionMeta::VERSION302B, MoPropertyMeta::READ_WRITE, 0x8, 0, 256, nil, [], []), 
        "remote_file" => MoPropertyMeta.new("remote_file", "remoteFile", "string", VersionMeta::VERSION302B, MoPropertyMeta::READ_WRITE, 0x10, nil, nil, %q{[^\(\)~`'\?\\"";<>\|&\*\^$%]{0,128}}, [], []), 
        "remote_server" => MoPropertyMeta.new("remote_server", "remoteServer", "string", VersionMeta::VERSION302B, MoPropertyMeta::READ_WRITE, 0x20, 0, 255, %q{(([0-9A-Fa-f]{1,4}:([0-9A-Fa-f]{1,4}:([0-9A-Fa-f]{1,4}:([0-9A-Fa-f]{1,4}:([0-9A-Fa-f]{1,4}:[0-9A-Fa-f]{0,4}|:[0-9A-Fa-f]{1,4})?|(:[0-9A-Fa-f]{1,4}){0,2})|(:[0-9A-Fa-f]{1,4}){0,3})|(:[0-9A-Fa-f]{1,4}){0,4})|:(:[0-9A-Fa-f]{1,4}){0,5})((:[0-9A-Fa-f]{1,4}){2}|:(25[0-5]|(2[0-4]|1[0-9]|[1-9])?[0-9])(\.(25[0-5]|(2[0-4]|1[0-9]|[1-9])?[0-9])){3})|(([0-9A-Fa-f]{1,4}:){1,6}|:):[0-9A-Fa-f]{0,4}|([0-9A-Fa-f]{1,4}:){7}:) |((([a-zA-Z0-9]([a-zA-Z0-9\-]{0,61}[a-zA-Z0-9])?\.)+[a-zA-Z]{2,6})|(([a-zA-Z0-9]([a-zA-Z0-9\-]{0,61}[a-zA-Z0-9])?)+)|([1-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])\.([0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])\.([0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])\.([1-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5]))}, [], []), 
        "rn" => MoPropertyMeta.new("rn", "rn", "string", VersionMeta::VERSION302B, MoPropertyMeta::READ_WRITE, 0x40, 0, 255, nil, [], []), 
        "status" => MoPropertyMeta.new("status", "status", "string", VersionMeta::VERSION302B, MoPropertyMeta::READ_WRITE, 0x80, nil, nil, nil, ["", "created", "deleted", "modified", "removed"], []), 
        "user" => MoPropertyMeta.new("user", "user", "string", VersionMeta::VERSION302B, MoPropertyMeta::READ_WRITE, 0x100, 0, 256, nil, [], []), 
        },

    }



    def self.prop_meta
        @@prop_meta
    end

    @@prop_map = {

        "classic" => {
        "childAction" => "child_action", 
        "dn" => "dn", 
        "downloadProgress" => "download_progress", 
        "downloadStatus" => "download_status", 
        "protocol" => "protocol", 
        "pwd" => "pwd", 
        "remoteFile" => "remote_file", 
        "remoteServer" => "remote_server", 
        "rn" => "rn", 
        "status" => "status", 
        "user" => "user", 
        },

    }



    def self.prop_map
        @@prop_map
    end

    attr_reader :child_action
    attr_reader :download_progress
    attr_reader :download_status
    attr_accessor :protocol
    attr_accessor :pwd
    attr_accessor :remote_file
    attr_accessor :remote_server
    attr_accessor :status
    attr_accessor :user


    def initialize(parent_mo_or_dn: nil,  **kwargs)
        @dirty_mask = 0
        @child_action = nil
        @download_progress = nil
        @download_status = nil
        @protocol = nil
        @pwd = nil
        @remote_file = nil
        @remote_server = nil
        @status = nil
        @user = nil

        super(class_id: "DownloadRootCACertificate", parent_mo_or_dn: parent_mo_or_dn, **kwargs)

    end
end
