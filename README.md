# Auto scaling and load balancer

Terraform code to manage a Auto scaling app with Load balancing feature and dedicated Networking(VPC, Subnet, Security groups). The backed of the environment is set to s3 for managing states.

# Code structure

The services are the managed in seperate environment to manage them seperately. 

`global` folder has a environment for creating S3 bucket and DynamoDB for backend.

`stage/networking` folder has a environment for creating VPC, Subnet and Security Group.

`stage/app` folder has a environment for creating the instance.

# Configuration

Add the `config.tf` file which has the backend configuration code to every environment's folder as follows.

```
/
|_global
|   |- config.tf
|   |- ...
|   .
|   .
|   
|_stage
    |-app
    | |-config.tf
    | |- ...
    | .
    | .
    |
    |-networking
      |- config.tf
      |- ...
      .
      .

```

The code for config looks like below

```
terraform {
  backend "s3" {
    # Replace this with your bucket name!
    bucket         = "bucket-name"
    key            = "state-file-save-location-in-bucket"
    region         = "bucket-region"

    # Replace this with your DynamoDB table name!
    dynamodb_table = "dynamodb-name"
    encrypt        = true
  }
}

```

# Credits

[Siva](https://github.com/Sivasankar4), [Pari](https://github.com/paripuranam) and [Gokul](https://github.com/gokul-20)

Feel free to check out their profiles 😊