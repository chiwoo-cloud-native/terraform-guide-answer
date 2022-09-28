# apple

## Init

인터넷 서비스를 위한 도메인을 발급 합니다.

- [AWS Route53 도메인 서비스 관리](https://symplesims.github.io/devops/route53/acm/hosting/2022/04/09/aws-route53.html) 블로그를 참고 하여 구성 합니다.

- 초기 구성을 위해 [init](./init/) 폴더에서 Elastic-IP 및 Key Pair 를 프로비저닝 합니다. 관리 콘솔을 통해 매뉴얼 구성을 할 수도 있습니다. 

```
terraform init

terraform plan

terraform apply
```


## Build

[resources](./resources/) 폴더에서 VPC, Bastion, Front-ALB, 애플리케이션 서비스용 EC2 등 AWS 리소스를 구성 합니다.    

### 워크스페이스 생성 및 선택 
```
terraform workspace new dev
terraform workspace new prd

terraform workspace select dev
terraform workspace list
```

### DEV 스택 프로비저닝 
``
- Step 1: 테라폼 init

초기 구성을 위해 [resources](./resources/) 폴더에서 init 명령어 실행 

```
terraform init 
```

<br>

- Step 2: Plan 을 통해 확인

```
terraform plan -var-file=tfvars/dev.tfvars
```

인스턴스 아이디를 사전에 식별해야만 구성이 가능한 리소스들이 있다. 

<br>

- step 3: VPC 만 사전 구성을 한다. 
```
terraform apply -var-file=tfvars/dev.tfvars

# 특정 모듈을 지정하여 프로비저닝 
# terraform plan -target=module.vpc -var-file=tfvars/dev.tfvars 
# terraform apply -target=module.vpc -var-file=tfvars/dev.tfvars 

```


```
terraform plan -var-file=tfvars/dev.tfvars
terraform apply -var-file=tfvars/dev.tfvars
```



## DDD

```

```
