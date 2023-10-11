# arduino_temperature

아두이노로 온도를 측정하고, 온도를 서버로 보내고, 화면에 표시하기 위해서 먼저, 아래와 같이 회로를 연결해줍니다.

![20231011_200912_HDR](https://github.com/naengku3/arduino_temperature/assets/127822478/0a23c49c-952e-4f61-9f0a-fa75d4ec2eaa)

위에서 각각 빨간선은 5v, 주황선은 A0, 검은선은 GND에 연결해주었고, 브레드보드에서는 사진과 같이 연결해 주었습니다. 저항은 순서대로 갈검주로 10k의 저항입니다.


```c++
void setup() {
  Serial.begin(9600);
}
double th(int v) {
  double t;
  t = log(((10240000/v) - 10000));
  t = 1 /(0.001129148 + (0.000234125*t) + (0.0000000876741*t*t*t));
  t = t - 273.15; // 화씨를 섭씨로 바꾸어줌
  return t;
}

void loop() {
  int a = analogRead(A0);
  Serial.println(th(a));
  delay(500);
}
```
다음은 아두이노 코드인데, 위 코드를 간략하게 설명하면 서버와 통신하기위해 Serial을 시작해주고, th()라는 함수를 통해 온도를 섭씨온도로 알맞게 바꿔주고, 
A0의 온도 센서 아날로그값을 변수 a에 저장해서 Serial에 th()함수를 통한 온도를 출력해주는 코드입니다. 


```processing
import processing.serial.*;

Serial p;
void setup() {
  p = new Serial(this, "COM11", 9600);
  size(400, 400);
}

void draw() {
  if(p.available()>0) {
  String m = p.readStringUntil('\n');
  if(m != null) {
    print(m);
    if( float(m) >28) background(255,0,0);
    else background(0,255,0);
    textSize(128);
    text(m, 20, 250);
    }
  }
}
```
다음은 processing 코드인데, 앞서 아두이노 코드에서의 Serial통신을 하기위해 import해서 Serial을 사용할 수 있도록하고,
Serial변수의 객체를 생성해서, Serial을 사용할 수 있을때, 그 데이터를 '\n'까지 읽어서 문자열 m에 저장하고, m이 null값이 아니면,
m을 출력하면서 값이28 이상이면 processing박스배경이 붉은색이 되도록 하는 코드입니다. 그리고 박스에는 텍스트로 온도도 표시가됩니다. 
