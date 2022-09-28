## Q1. terraform destroy 를 한 뒤에 다시 terraform apply 명령을 실행하면 어떤 일이 벌어지나요?

```
destroy 이전에 생성된 REAL 인프라가 다시 생성 됩니다.
```

<br>

## Q2. terraform apply 를 한 뒤에 terraform.tfstate 파일을 삭제 하고 terraform apply 명령을 실행하면 어떤일이 벌어지나요?

```
이미 생성된 REAL 인프라를 동일하게 다시 생성 하려고 시도 합니다. 하지만 동일한 인스턴스가 이미 존재하므로 충돌이 일어나며 오류가 발생 됩니다.  
```

<br>

## Q3. terraform apply 진행중에 다른 사람이 terraform apply 명령을 실행하면 어떤 일이 벌어지나요?

```
REAL 인프라 구성시 동일한 REAL 인프라를 경합하며 생성 하려고 시도하며 충돌 및 상태 반영이 뒤죽박죽 되어 문제가 발생 합니다.   
```


<br>

## Q4. 팀에서 다른 동료와 같이 테라폼 코드를 통해 REAL 인프라를 공동으로 관리 한다면 어떻게 해야 하나요?

```
소스 코드(HCL)와 tfstate 상태 파일을 항상 최신의 버전으로 원격 저장소에 관리 하여야 합니다.

특히, 프로비저닝 및 tfsate 상태 파일 액세스에 대해서 트랜잭션을 보장 하여야 합니다.

예) github, s3 등 
```

<br>

## Q5. terraform 명령을 통해 plan, apply, destroy 를 확인 하세요.

- terraform 코드를 작성 하세요.
- AWS 프로바이더에서 제공하는 리소스로 유형은 제한이 없습니다.
- terraform plan, apply, destroy 를 확인 하세요.


<br>

## Q6. terraform 상태 파일 Quiz

다음과 같이 terraform 코드로 aws_vpc 리소스를 정의 하고 terraform apply 를 통해 프로비저닝 한다고 가정할때 Operation 은 어떻게 될까요?

```
resource "aws_vpc" "my_vpc" {
  cidr_block = "172.16.0.0/16"

  tags = {
    Name = "tf-example"
  }
}
```

| Code (*.tf) | tfstate | REAL Infra |  Operation  | 
|:-----------:|:-------:|:----------:|:-----------:|
|   aws_vpc   |    -    |     -      | &lt;QA1&gt; |
|   aws_vpc   | aws_vpc |     -      | &lt;QA2&gt; |
|   aws_vpc   | aws_vpc |  aws_vpc   | &lt;QA3&gt; |
|      -      | aws_vpc |  aws_vpc   | &lt;QA4&gt; |
|      -      |    -    |  aws_vpc   | &lt;QA5&gt; |
|      -      | aws_vpc |            | &lt;QA6&gt; |


올 수 있는 Operation 은 create REAL, delete REAL, update state, '-' 입니다.  
 
```
QA1: create REAL
QA2: create REAL
QA3: -
QA4: delete REAL
QA5: -
QA6: update state
```

