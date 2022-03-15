
# 투수, 타자 csv파일 읽고 회귀분석
setwd("c:/r_temp")
DF <- read.csv("pitcher2.csv", header = T, fileEncoding = "EUC-KR")
DF
DFT <- read.csv("hitting.csv", header = T, fileEncoding = "EUC-KR")
DFT

# 상관계수
cor(DF$ERA, DF$height) 
cor(DF$SLG, DF$height) 
cor(DFT$AVG, DFT$height)
cor(DFT$SLG, DFT$height) 

# 해발고도 별 투수 평균 방어율과 피장타율/ 타자 평균 타율과 장타율
aggregate(ERA ~ height, DF, mean)
aggregate(SLG ~ height, DF, mean)
aggregate(AVG ~ height, DFT, mean)
aggregate(SLG ~ height, DFT, mean)


# 분산, 표준편차, 표준화 
var(DF$ERA, na.rm=T)
var(DF$ERA, DF$SLG, na.rm=T)
sd(DF$ERA, na.rm=T)
z <- scale(DF$ERA)
z

# 구장 별 투수 방어율 회귀분석
par(mfrow=c(1,1))
Lm <- lm(ERA ~ height, data = DF)
options(scipen = 999)
Lm
summary(Lm)

# 회귀식-> ERA(방어율) = 3.4091278 + 0.009842*height (해발고도)
# 설명력이 조금 낮은 이유는 방어율은 해발고도 말고도 다른 변수에 의해 영향을 받을 것으로 예상됩니다(바람, 해안근처, 습도 등)

# 구장 별 투수 피장타율 회귀분석
Lm2 <- lm(SLG ~ height, data = DF)
options(scipen = 999)
Lm2
summary(Lm2)

# 회귀식-> SLG(피장타율)= 0.345949816 + 0.000076085*height(해발고도) 

# 구장 별 타자 평균 타율 회귀분석
Lm3 <- lm(AVG ~ height, data = DFT)
options(scipen = 999)
Lm3
summary(Lm3)

# 구장 별 타자 평균 장타율 회귀분석
Lm4 <- lm(SLG ~ height, data = DFT)
options(scipen = 999)
Lm4
summary(Lm4)



# 잔차산점도
par(mfrow=c(2,2))
plot(Lm) 
plot(Lm2)
plot(Lm3)
plot(Lm4)

# 정규성 가정을 검정 Shapiro-Wilk test
shapiro.test(resid(Lm)) 
shapiro.test(resid(Lm2))
shapiro.test(resid(Lm3))
shapiro.test(resid(Lm4))

# 정규성을 확인해보면 p-value값이 0.808, 0.4356으로 크게 나온다.
# 따라서 귀무가설이 채택되어 위 모형의 잔차들이 정규분포를 따르고 있음을 나타낸다.

#resid()함수는 인수의 적합한 모형식을 입력받아 해당 모형의 잔차를 return하는 함수

# 방어율 Residuals vs Fitted, scale - Location 유사함(랜덤일수록 좋지만 규칙성이 보임)
# 또한 Normal Q-Q로 보았을 때 기준선에 대부분의 점들이 놓여 있기 때문에 정규성을 만족한다고 볼 수 있으며
# Residuals vs Leverage 의 경우 대다수 값들이 한쪽으로 몰려있는 형태를 보이고 있기 때문에



# 산점도 (해발고도가 높은 구장들과 낮은 구장들로 구분하였기 때문에 산점도가 극과 극으로 보여짐)

par(mfrow=c(1,2))
plot(DF$ERA~ DF$height, pch=20,col ="grey",cex = 1.5) 
plot(DF$SLG~ DF$height, pch=20,col ="red",cex = 1.5) 

plot(DFT$AVG~ DF$height, pch=20,col ="grey",cex = 1.5) 

plot(DFT$SLG~ DF$height, pch=20,col ="red",cex = 1.5) 
#################시각화#################
# 경기장별 위치 시각화

mean(DF$lat) # 위도
mean(DF$lon) # 경도

up <- subset(DF, DF$lat>34.54114)
up2 <- subset(up, DF$lon> -104.242)

center <- c(mean(DF$lon),mean(DF$lat))
center

install.packages("ggmap")
install.packages("ggplot2")
library(ggmap)
library(ggplot2)

map <- get_googlemap(center=center, maptype = "terrain", zoom=4)
ggmap(map)+geom_point(data = DF ,aes(DF$lon, DF$lat, size = height, col= "red", alpha = 1.5))

# 해발고도가 높아질수록 구장 별 평균 방어율과 피장타율이 상승(시각화)
ggplot(data = DF, aes(x= ERA, y =height))+geom_point(aes(colour=teams))+geom_smooth()
ggplot(data = DF, aes(x= SLG, y =height))+geom_point(aes(colour=teams))+geom_smooth()

# 해발고도가 높아질수록 구장 별 평균 타율과 피장타율이 상승(시각화)
ggplot(data = DFT, aes(x= AVG, y =height))+geom_point(aes(colour=teams))+geom_smooth()
ggplot(data = DFT, aes(x= SLG, y =height))+geom_point(aes(colour=teams))+geom_smooth()

#ggplot(data = DF, aes(x= ERA, y =height,colour=teams))+geom_point()+geom_smooth()
#p=ggplot(data=DF,aes(x=ERA,y=height))
#p+geom_smooth()
#p+geom_smooth(aes(group=teams))

# 전체 구장 위치 시각화

fd <- read.csv("fields.csv", header = T)
fd
fd <- na.omit(fd)

center <- c(mean(fd2$lat),mean(fd2$lon))
center

map <- get_googlemap(center=center, maptype = "terrain", zoom=3)
ggmap(map)+geom_point(data = fd,aes(fd$lat, fd$lon, size = 3, col= "red", alpha = 1))
