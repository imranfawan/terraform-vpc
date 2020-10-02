
## Overview

This terraform module will provision a VPC in a given region. It will also create three private / public subnets across three specified
availability zones. 
   
## Usage

Example of the module's usage is as follows:

Execute `terraform apply` from the `example` folder.

```{r, engine='bash', count_lines}

module "vpc" {
  #source = "../"
  source = "github.com/imranfawan/terraform-vpc?ref=v1.0"
  vpc_name = "demo"
  aws_region = "eu-west-1"
  aws_zone_1a = "eu-west-1a"
  aws_zone_1b = "eu-west-1b"
  aws_zone_1c = "eu-west-1c"
}

```

You may run the module locally by cloning the module and simply assigning the `source` to `..\`.

