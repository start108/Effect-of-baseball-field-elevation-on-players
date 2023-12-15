<h2 align="center">야구장의 해발고도가 선수에게 미치는 영향 ⚾️</h1>

&nbsp;

## Index

* [About Project](#about-Project)
* [Stacks](#stacks)
* [Details](#details)
  * [Data Collection](#data-collection)
  * [Data Analysis/Visualization](#data-Analysis/visualization)
  * [Result](#result)

&nbsp;&nbsp;&nbsp;

## About Project

- 야구에 관심 있어 하는 학생 3명이 주제선정 중 공통의 관심사인 야구로 정한 뒤 어떠한 요인들이 야구의 경기 결과에 영향을 미치는지 알아보기 위해 조사하였습니다.
  다양한 요인들을 찾던 중 과학적으로 입증이 가능하고 자료 분석을 통한 결론 도출에 용이한 "야구장의 해발고도가 선수에게 미치는 영향"을 주제로 선정하였습니다.

- "구장의 위치가 해발이 높은 곳에 위치할수록 타자의 타율, 장타율은 상승할 것이고, 투수의 방어율, 피장타율은 감소할 것이다" 라는 가설을 세우고 실제 결과 값으로 수렴하는지에 대해 10년(2008~2017)간의 데이터를 토대로 분석하였습니다.

&nbsp;

## Stacks
![R](https://img.shields.io/badge/-R-276DC3?style=for-the-badge&logo=R&logoColor=white)

&nbsp;

## Details(작성중...)

### Data Collection
<table>
  <thead>
    <th>투수</th>
    <th>타자</th>
  </thead>
  <tbody>
   <tr>
    <th>구장별 방어율, 피장타율</th>
    <th>구장별 타율, 장타율</th>
   </tr>
   <tr>
    <td>
        <img align="center" src="https://github.com/start108/Effect-of-baseball-field-elevation-on-players/assets/46213056/eeb30c6f-4432-415f-af16-18089fa01a5b" width="300" height="165" alt-text="투수">
     </td>
    <td>
        <img align="center" src="https://github.com/start108/Effect-of-baseball-field-elevation-on-players/assets/46213056/9367f4c4-f8db-44c7-bb16-7e80eb89bf0a" width="300" height="165" alt-text="타자">
     </td>
   </tr>
  </tbody>
</table>

&nbsp;

- 투수 데이터로는 구장별 방어율과 피장타율, 타자는 구장별 타율과 장타율 마지막으로 구장별 데이터로는 30개 구장의 경/위도, 해발고도를 csv 파일화 하였습니다.

&nbsp;

<table>
  <tbody>
   <tr>
     <td>
        <img align="center" src="https://github.com/start108/Effect-of-baseball-field-elevation-on-players/assets/46213056/74f2a49f-8498-42c2-b858-9598c0aa07bb" width="300" height="200" alt-text="메이저리그 구장">
     </td>
     <td>
        <img align="center" src="https://github.com/start108/Effect-of-baseball-field-elevation-on-players/assets/46213056/872051f5-4d70-4c81-b4d1-0c6ad737f36f" width="400" height="230">
     </td>
    <td>
        <img align="center" src="https://github.com/start108/Effect-of-baseball-field-elevation-on-players/assets/46213056/e628d3b4-ba23-40e6-b0b7-bf6893b058a9" width="400" height="230">
     </td>
   </tr>
  </tbody>
</table>

&nbsp;

- 메이저리그 30개팀 중 해발고도가 높은 상/하위 8개의 구장을 선정하였으며, 최근 10년 간의 기록 자료 수집을 하였습니다.

&nbsp;

### Data Analysis/Visualization

```r

# 투수, 타자 데이터 csv파일 읽기
setwd("c:/r_project")
DF <- read.csv("pitcher.csv", header = T, fileEncoding = "EUC-KR")
DF
DFT <- read.csv("hitting.csv", header = T, fileEncoding = "EUC-KR")
DFT

# 상관계수
cor(DF$ERA, DF$height) 
cor(DF$SLG, DF$height) 
cor(DFT$AVG, DFT$height)
cor(DFT$SLG, DFT$height)

# 해발고도 별 투수의 평균 방어율/피장타율, 타자의 타율/장타율
aggregate(ERA ~ height, DF, mean)
aggregate(SLG ~ height, DF, mean)
aggregate(AVG ~ height, DFT, mean)
aggregate(SLG ~ height, DFT, mean)

install.packages("ggmap")
install.packages("ggplot2")
library(ggmap)
library(ggplot2)

map <- get_googlemap(center = center, maptype = "terrain", zoom = 4)
ggmap(map)+geom_point(data = DF ,aes(DF$lon, DF$lat, size = height, col = "red", alpha = 1.5))

# 구장별 평균 방어율/피장타율 시각화
ggplot(data = DF, aes(x = ERA, y = height))+geom_point(aes(colour = teams))+geom_smooth()
ggplot(data = DF, aes(x = SLG, y = height))+geom_point(aes(colour = teams))+geom_smooth()

# 구장별 평균 타율/장타율 시각화
ggplot(data = DFT, aes(x = AVG, y = height))+geom_point(aes(colour = teams))+geom_smooth()
ggplot(data = DFT, aes(x = SLG, y = height))+geom_point(aes(colour = teams))+geom_smooth()

```

&nbsp;

<table>
  <tbody>
   <tr>
    <th>상관계수</th>
   </tr>
   <tr>
     <td>
        <img align="center" src="https://github.com/start108/Effect-of-baseball-field-elevation-on-players/assets/46213056/d5959ccd-d8aa-411e-884a-5b022f7e4dcf" width="225" height="150" alt-text="상관계수">
     </td>
   </tr>
  </tbody>
</table>

&nbsp;

<table>
  <thead>
  <tr>
    <th colspan="2">투수</th>
    <th colspan="2">타자</th>
   </tr>
  </thead>
  <tbody>
   <tr>
    <th>평균 방어율</th>
    <th>평균 피장타율</th>
    <th>평균 타율</th>
    <th>평균 장타율</th>
   </tr>
   <tr>
     <td>
        <img align="center" src="https://github.com/start108/Effect-of-baseball-field-elevation-on-players/assets/46213056/7c7895a0-890b-40c6-ae96-da05743cd57e" width="300" height= "165">
    </td>
    <td>
        <img align="center" src="https://github.com/start108/Effect-of-baseball-field-elevation-on-players/assets/46213056/d9fd045f-0a56-4358-aec0-d6cc86d008ed" width="300" height= "165">
    </td>
    <td>
        <img align="center" src="https://github.com/start108/Effect-of-baseball-field-elevation-on-players/assets/46213056/e4425a0b-2f66-4831-855a-f3331ef00747" width="300" height= "165">
    </td>
    <td>
        <img align="center" src="https://github.com/start108/Effect-of-baseball-field-elevation-on-players/assets/46213056/31ef20ee-5d20-439f-91ba-1eb398028c36" width="300" height= "165">
    </td>
   </tr>
  </tbody>
</table>

&nbsp;

<table>
  <tbody>
    <tr>
     <td>
        <img align="center" src="https://github.com/start108/Effect-of-baseball-field-elevation-on-players/assets/46213056/664a28c8-01e9-4c65-aa5c-9fc6f3804d9b" width="300" height= "165">
     </td>
     <td>
         <img align="center" src="https://github.com/start108/Effect-of-baseball-field-elevation-on-players/assets/46213056/dc836394-612a-47f9-b005-def3f69111c8" width="300" height= "165">
     </td>
     <td>
         <img align="center" src="https://github.com/start108/Effect-of-baseball-field-elevation-on-players/assets/46213056/28a1183c-2027-40e5-8cb3-29d5a6ab3f36" width="300" height= "165">
     </td>
     <td>
         <img align="center" src="https://github.com/start108/Effect-of-baseball-field-elevation-on-players/assets/46213056/abbf120d-cd62-47cd-b2c5-2ca232bb1746" width="300" height= "165">
     </td>
   </tr>
  </tbody>
</table>

&nbsp;

- 각 종속변수와 독립변수와의 상관관계는 모두 강한 양의 상관관계를 나타내고 있으며,
  구장의 해발고도가 높아짐에 따라 투수의 평균 방어율과 평균 피장타율, 타자의 평균 타율과 평균 장타율이 모두 상승하는 것을 볼 수 있습니다.

&nbsp;

```r

# 구장별 투수 평균 방어율
par(mfrow=c(1,1))
Lm <- lm(ERA ~ height, data = DF)
options(scipen = 999)
Lm
summary(Lm)

# 구장별 투수 평균 피장타율
Lm2 <- lm(SLG ~ height, data = DF)
options(scipen = 999)
Lm2
summary(Lm2)

# 구장별 타자 평균 타율
Lm3 <- lm(AVG ~ height, data = DFT)
options(scipen = 999)
Lm3
summary(Lm3)

# 구장별 타자 평균 장타율
Lm4 <- lm(SLG ~ height, data = DFT)
options(scipen = 999)
Lm4
summary(Lm4)

```

&nbsp;

<table>
  <thead>
  <tr>
    <th colspan="2">투수</th>
    <th colspan="2">타자</th>
   </tr>
  </thead>
  <tbody>
   <tr>
    <th>평균 방어율</th>
    <th>평균 피장타율</th>
    <th>평균 타율</th>
    <th>평균 장타율</th>
   </tr>
   <tr>
     <td>
        <img align="center" src="https://github.com/start108/Effect-of-baseball-field-elevation-on-players/assets/46213056/0dfe9dd4-c4df-4ab8-a8e7-06075b43b3c6" width="300" height= "165">
    </td>
    <td>
        <img align="center" src="https://github.com/start108/Effect-of-baseball-field-elevation-on-players/assets/46213056/ca2f09c8-3a67-4e77-81cd-102fad8c3f62" width="300" height= "165">
    </td>
    <td>
        <img align="center" src="https://github.com/start108/Effect-of-baseball-field-elevation-on-players/assets/46213056/945f184f-cda1-4f75-a881-d2a5e5ecabc4" width="300" height= "165">
    </td>
    <td>
        <img align="center" src="https://github.com/start108/Effect-of-baseball-field-elevation-on-players/assets/46213056/b6ae94ec-8de5-42b2-b0ef-a4b3bc64d50d" width="300" height= "165">
    </td>
   </tr>
  </tbody>
</table>

&nbsp;

- 단순회귀분석을 통해 분석 시 투수의 방어율과 피장타율, 타자의 타율과 장타율 모두 해발고도에 영향이 있는 것으로 나타났습니다.
  또한 P-value값이 0.05이하로 유의하였으며 방어율은 약 46%, 피장타율은 약 65%, 타율은 약 69%, 장타율은 약 68%의 설명력을 가지고 있었습니다.

&nbsp;

<table>
  <thead>
  <tr>
    <th colspan="2">투수</th>
    <th colspan="2">타자</th>
   </tr>
  </thead>
  <tbody>
   <tr>
    <th>평균 방어율</th>
    <th>평균 피장타율</th>
    <th>평균 타율</th>
    <th>평균 장타율</th>
   </tr>
   <tr>
     <td>
        <img align="center" src="https://github.com/start108/Effect-of-baseball-field-elevation-on-players/assets/46213056/0dfe9dd4-c4df-4ab8-a8e7-06075b43b3c6" width="300" height= "165">
    </td>
    <td>
        <img align="center" src="https://github.com/start108/Effect-of-baseball-field-elevation-on-players/assets/46213056/ca2f09c8-3a67-4e77-81cd-102fad8c3f62" width="300" height= "165">
    </td>
    <td>
        <img align="center" src="https://github.com/start108/Effect-of-baseball-field-elevation-on-players/assets/46213056/945f184f-cda1-4f75-a881-d2a5e5ecabc4" width="300" height= "165">
    </td>
    <td>
        <img align="center" src="https://github.com/start108/Effect-of-baseball-field-elevation-on-players/assets/46213056/b6ae94ec-8de5-42b2-b0ef-a4b3bc64d50d" width="300" height= "165">
    </td>
   </tr>
  </tbody>
</table>

&nbsp;

### Result
