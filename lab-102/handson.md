# Terraform Basic Hands On

## Q1. 프로바이더를 정의 하세요.

- Terraform 버전을 1.2.5 버전과 같거나 상위 버전에서만 동작하도록 정의 하세요.
- AWS 프로바이더를 추가 하고, 버전은 "4.4.0" 과 크거나 같아야 합니다.
- terra 프로파일을 사용하며, '서울' 리전을 액세스 하여야
합니다.

```hcl
terraform {
  required_version = ">= 1.2.5"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.4.0"
    }
  }
}

provider "aws" {
  profile = "terra"
  region  = "ap-northeast-2"
}

```

## Q2. Bastion-EC2 를 위한 `aws_instance` 리소스를 정의 하세요
- 인스턴스 갯수는 1개 입니다.
- 이름은 my-bastion 입니다.
- instance_type 은 t2.micro 입니다.
- ami 이미지 아이디는 "ami-08f869ae259b6bc98" 입니다.
- ManagedBy, Team, Owner, OS 등 필요한 태그 속성들을 추가 하세요.

[Q2-bastion](./q2-bastion/)

```shell
cd $PDIR/lab-102/q2-bastion/

terraform init

terraform plan
```


## Q3. aws_instance 리소스 속성을 변경 하세요.

- api 종료 방지 기능 활성화 여부를 변수를 통해 구성 될 수 있도록 보완 하세요.  
- instance_type 을 변수를 통해 구성 될 수 있도록 보완 하고, 입력 값이 없으면 't3.small' 값을 기본값으로 설정 하도록 보완 하세요.

[Q3-bastion](./q3-bastion/)


```shell
cd $PDIR/lab-102/q3-bastion/

terraform init

terraform plan -var="disable_api_termination=true"
```

## Q4. 가장 최신의 ubuntu `aws_ami` 데이터 소스를 정의 하고, output 으로 ami_id 를 출력 하세요.

[Q4-ami](./q4-ami/)

```shell
cd $PDIR/lab-102/q4-ami/

terraform init

terraform plan
```

