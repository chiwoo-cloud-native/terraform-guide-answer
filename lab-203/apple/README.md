# apple

## Git
```
git clone https://github.com/chiwoo-cloud-native/terraform-guide-answer.git

git config --local user.name symplesims
git config --local user.email symplesims@gmail.com

cd terraform-guide-answer/lab-203/apple

# PDIR 환경변수로 apple 디렉토리 경로 저장
export PDIR=$(pwd)
```

## Init

인터넷 서비스를 위한 도메인을 발급 합니다.

- [AWS Route53 도메인 서비스 관리](https://symplesims.github.io/devops/route53/acm/hosting/2022/04/09/aws-route53.html) 블로그를 참고 하여 구성 합니다.

- 초기 구성을 위해 [init](./init/) 폴더에서 Elastic-IP 및 Key Pair 를 프로비저닝 합니다. 관리 콘솔을 통해 매뉴얼 구성을 할 수도 있습니다. 

```
# init 초기 구성 프로젝트 경로 이동 
cd $PDIR/init

terraform init

terraform plan

terraform apply
```


## Build

[resources](./resources/) 폴더에서 VPC, Bastion, Front-ALB, 애플리케이션 서비스용 EC2 등 AWS 리소스를 구성 합니다.    

### 워크스페이스 생성 
```
# resources 초기 구성 프로젝트 경로 이동 
cd $PDIR/resources

terraform workspace new dev
terraform workspace new prd
```

### DEV 스택 프로비저닝 

- Step 1: `dev` 워크스페이스 선택 
```
terraform workspace select dev
terraform workspace list
```

<br>

- Step 2: 테라폼 프로젝트 초기화 및 프로비저닝

```
terraform init

# 입력 변수를 dev.tfvars 로 지정 하여야 합니다. 
terraform plan -var-file=tfvars/dev.tfvars

# apply
terraform apply -var-file=tfvars/dev.tfvars
```

<br>

- 모듈화는 규격화된 템플릿으로 입력 변수에 해당하는 REAL 인프라를 자동화 구성하는 장점이 있습니다.  
뿐만 아니라, -target 지정을 통해 특정 모듈만을 대상으로 프로비저닝이 가능 합니다. 
```
# 특정 모듈을 지정하여 프로비저닝 
# terraform plan -target=module.vpc -var-file=tfvars/dev.tfvars 
# terraform apply -target=module.vpc -var-file=tfvars/dev.tfvars 
```

<br>

- Step 3: REAL 인프라 삭제 
```
terraform destroy -var-file=tfvars/dev.tfvars
```
