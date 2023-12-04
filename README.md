<h2 align="center">야구장의 해발고도가 선수에게 미치는 영향 ⚾️</h1>

&nbsp;

## Index

* [About Project](#about-Project)
* [Stacks](#stacks)
* [Details](#details)
  * [Data Analysis](#data-Analysis)
  * [Visualization](#visualization)

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

### Data Analysis
<table>
  <tbody>
   <tr>
    <th>메이저리그 구장</th>
    <th>구장별 방어율, 피장타율(투수)</th>
    <th>구장별 타율, 장타율(타자)</th>
   </tr>
   <tr>
     <td>
        <img align="center" src="https://github.com/start108/Effect-of-baseball-field-elevation-on-players/assets/46213056/74f2a49f-8498-42c2-b858-9598c0aa07bb" width="300" height= "165" alt-text="메이저리그 구장">
     </td>
    <td>
        <img align="center" src="https://github.com/start108/Effect-of-baseball-field-elevation-on-players/assets/46213056/eeb30c6f-4432-415f-af16-18089fa01a5b" width="300" height= "165" alt-text="투수">
     </td>
    <td>
        <img align="center" src="https://github.com/start108/Effect-of-baseball-field-elevation-on-players/assets/46213056/9367f4c4-f8db-44c7-bb16-7e80eb89bf0a" width="300" height= "165" alt-text="타자">
     </td>
   </tr>
  </tbody>
</table>

- 데이터 수집은 mlb.com, espn.com에서 하였으며, 타자의 구장별 타율과 장타율, 투수의 구장별 방어율과 피장타율, 마지막으로 구장별 위치 시각화를 위해 30개 구장의 경/위도, 해발고도를 csv 파일화 하였습니다.

```r

# 투수, 타자 csv파일 읽기
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

```
### Visualization
