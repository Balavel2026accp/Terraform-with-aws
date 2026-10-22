# defining general variable that required to infra elements
# Region variable value

variable "region" {
  description = "The region value where this resource going to get provisioned"  
  type = string
  default = "ap-south-1"
}

variable "Environment" {
  description = "The environment of which this resouce getting created"
  type = string
  default = "dev"
}

variable "Business-unit" {
  description = "Business unit of the resource"
  type = string
  default = "TOE-FPM-ISPL"
}