/**
 * Copyright 2020 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

variable "peer_external_gateway" {
  description = "Configuration of an external VPN gateway to which this VPN is connected."
  type = object({
    redundancy_type = string
    interfaces = list(object({
      id         = number
      ip_address = string
    }))
  })
  default = null
}

variable "peer_gcp_gateway" {
  description = "Self Link URL of the peer side HA GCP VPN gateway to which this VPN tunnel is connected."
  type        = string
  default     = null
}

variable "name" {
  description = "VPN gateway name, and prefix used for dependent resources."
  type        = string
}

variable "network" {
  description = "VPC used for the gateway and routes."
  type        = string
}

variable "project_id" {
  description = "Project where resources will be created."
  type        = string
}

variable "region" {
  description = "Region used for resources."
  type        = string
}

variable "route_priority" {
  description = "Route priority, defaults to 1000."
  type        = number
  default     = 1000
}

variable "router_advertise_config" {
  description = "Router custom advertisement configuration, ip_ranges is a map of address ranges and descriptions."
  type = object({
    groups    = list(string)
    ip_ranges = map(string)
    mode      = string
  })
  default = null
}

variable "router_asn" {
  description = "Router ASN used for auto-created router."
  type        = number
  default     = 64514
}

variable "router_name" {
  description = "Name of router, leave blank to create one."
  type        = string
  default     = ""
}

variable "tunnels" {
  description = "VPN tunnel configurations, bgp_peer_options is usually null."
  type = map(object({
    bgp_peer = object({
      address = string
      asn     = number
    })
    bgp_peer_options = object({
      ip_address          = string
      advertise_groups    = list(string)
      advertise_ip_ranges = map(string)
      advertise_mode      = string
      route_priority      = number
    })
    bgp_session_range               = string
    ike_version                     = number
    vpn_gateway_interface           = number
    peer_external_gateway_interface = number
    shared_secret                   = string
  }))
  default = {}
}

variable "vpn_gateway_self_link" {
  description = "self_link of existing VPN gateway to be used for the vpn tunnel"
  type        = string
  default     = null
}

variable "create_vpn_gateway" {
  description = "create a VPN gateway"
  default     = true
  type        = bool
}

variable "labels" {
  description = "Labels for vpn components"
  type        = map(string)
  default     = {}
}
