class Song {
  final String title;
  final String author;
  final String url;
  final String image;
  final String lyrics;
  bool isCurrentPlaying;

  Song({
    required this.title,
    required this.author,
    required this.url,
    required this.image,
    required this.lyrics,
    this.isCurrentPlaying = false,
  });
}

class SongData {
  static List<Song> songs = [
    Song(
      title: 'Flower',
      author: 'Jisoo',
      url: 'assets/audio/Y2meta.app - JISOO - ‘꽃(FLOWER)’ M_V (128 kbps).mp3',
      image:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRc9gtzgargQrvVZrLT-7cGQXc6VvM22b4cqQ&s',
      lyrics: '''
Eh-eh-eh-eh
Eh-eh-eh-eh
A-B-C, Do-Re-Mi 만큼 착했던 나
그 눈빛이 싹 변했지
어쩜 이 또한 나니까
난 파란 나비처럼 날아가
잡지 못한 건 다 네 몫이니까
활짝 꽃 피웠던 시간도 이제 모두
내겐 lie, lie, lie
붉게 타버려진 너와 나
난 괜찮아, 넌 괜찮을까?
구름 한 점 없이 예쁜 날
꽃향기만 남기고 갔단다
꽃향기만 남기고 갔단다
You and me 미칠 듯이 뜨거웠지만
처참하게 짓밟혀진 내 하나뿐인 lilac
난 하얀 꽃잎처럼 날아가
잡지 않는 것은 너니까
살랑살랑 부는 바람에 이끌려
봄은 오지만 우린 bye, bye, bye
붉게 타버려진 너와 나
난 괜찮아, 넌 괜찮을까?
구름 한 점 없이 예쁜 날
꽃향기만 남기고 갔단다
꽃향기만 남기고 갔단다
이젠 안녕 goodbye
뒤는 절대 안 봐
미련이란 이름의 잎새 하나
봄비에 너에게서 떨어져
꽃향기만 남아 hey, hey
Hey, hey
Hey, hey
꽃향기만 남기고 갔단다
''',
      isCurrentPlaying: false,
    ),
    Song(
      title: 'DDU-DU DDU-DU',
      author: 'BLACKPINK',
      url:
          'assets/audio/Y2meta.app - BLACKPINK - ‘뚜두뚜두 (DDU-DU DDU-DU)’ M_V (128 kbps).mp3',
      image: 'https://i.ytimg.com/vi/IHNzOHi8sJs/maxresdefault.jpg',
      lyrics: ''' BLACKPINK
Ah-yeah, ah-yeah
BLACKPINK
Ah-yeah, ah-yeah
Eh
착한 얼굴에 그렇지 못한 태도 (uh-huh)
가녀린 몸매 속 가려진 volume은 두 배로 (yo, yo, double up)
거침없이 직진, 굳이 보진 않지 눈치 (ooh)
Black 하면 pink 우린 예쁘장한 savage (BLACKPINK)
원할 땐 대놓고 뺏지 (uh)
넌 뭘 해도 칼로 물 베기 (uh)
두 손엔 가득한 fat checks
궁금하면 해봐 fact check
눈 높인 꼭대기, 물 만난 물고기
좀 독해 난 toxic, you 혹해 I'm foxy
두 번 생각해
흔한 남들처럼 착한 척은 못 하니까
착각하지 마
쉽게 웃어주는 건 날 위한 거야
아직은 잘 모르겠지
굳이 원하면 test me
넌 불 보듯이 뻔해
만만한 걸 원했다면
Oh, wait 'til I do what I
Hit you with that ddu-du, ddu-du, du
Ah-yeah, ah-yeah
Hit you with that ddu-du, ddu-du, du
Ah-yeah, ah-yeah
(Du-du, du-du-du-du-du)
BLACKPINK
지금 내가 걸어가는 거린
BLACKPINK four way 사거리
동서남북 사방으로 run it
니네 버킷리스트 싹 다 I bought it
널 당기는 것도, 멀리 밀치는 것도
제멋대로 하는 bad girl
좋건, 싫어하건, 누가 뭐라 하던
When the bass drop, it's another banger
두 번 생각해
흔한 남들처럼 착한 척은 못 하니까
착각하지 마
쉽게 웃어주는 건 날 위한 거야
아직은 잘 모르겠지
굳이 원하면 test me
넌 불 보듯이 뻔해
만만한 걸 원했다면
Oh, wait 'til I do what I
Hit you with that ddu-du, ddu-du, du
Ah-yeah, ah-yeah
Hit you with that ddu-du, ddu-du, du
Ah-yeah, ah-yeah
(Du-du, du-du-du-du-du)
What you gonna do when I come, come through
With that, that? Uh (uh), uh-huh (uh-huh)
What you gonna do when I come, come through
With that, that? Uh (uh), uh-huh (uh-huh)
뜨거워, 뜨거워, 뜨거워 like fire (fire)
(Du-du, du-du-du-du-du)
(Du-du, du-du-du-du-du)
뜨거워, 뜨거워, 뜨거워 like fire (fire)
(Du-du, du-du-du-du-du)
(Du-du, du-du-du-du-du)
BLACKPINK
Hey
(Du-du, du-du-du-du, du-du-du-du)
Ah-yeah, ah-yeah, ah-yeah, ah-yeah
뜨거워, 뜨거워, 뜨거워 like fire (fire, hey)
뜨거워, 뜨거워, 뜨거워 like fire (fire)
Hit you with that ddu-du, ddu-du, du
''',
      isCurrentPlaying: false,
    ),
    Song(
      title: 'Kill This Love',
      author: 'BLACKPINK',
      url:
          'assets/audio/Y2meta.app - BLACKPINK - \'Kill This Love\' M_V (128 kbps).mp3',
      image:
          'https://ss-images.saostar.vn/2019/04/07/4920635/blackpink-kill-this-love-mv-2019-billboard-1548.jpg',
      lyrics: '''Yeah, yeah, yeah
BLACKPINK in your area
Yeah, yeah, yeah
천사 같은 "Hi" 끝엔 악마 같은 "Bye"
매번 미칠듯한 high 뒤엔 뱉어야 하는 price
이건 답이 없는 test
매번 속더라도 yes
딱한 감정의 노예
얼어 죽을 사랑해 yeah
Here I come kick in the door, uh
가장 독한 걸로 줘 uh
뻔하디 뻔한 그 love (love)
더 내놔봐 give me some more
알아서 매달려 벼랑 끝에
한마디면 또 like 헤벌레 해
그 따뜻한 떨림이 새빨간 설렘이
마치 heaven 같겠지만
You might not get in it
Look at me, look at you
누가 더 아플까
You smart (you smart) 누가 you are
두 눈에 피눈물 흐르게 된다면
So sorry (so sorry) 누가 you are
나 어떡해 나약한 날 견딜 수 없어
애써 두 눈을 가린 채
사랑의 숨통을 끊어야겠어
Let's kill this love
Yeah, yeah, yeah, yeah, yeah
Rum, pum, pum, pum, pum, pum, pum
Let's kill this love
Rum, pum, pum, pum, pum, pum, pum
Feelin' like a sinner
It's so fire with him I go boo, ooh
He said you look crazy
Thank you, baby
I owe it all to you
Got me all messed up
His love is my favorite
But you plus me
Sadly can be dangerous
Lucky me, lucky you
결국엔 거짓말 we lie (we lie)
So what? So what?
만약에 내가 널 지우게 된다면 so sorry
I'm not sorry (I'm not sorry)
나 어떡해 나약한 날 견딜 수 없어
애써 눈물을 감춘 채
사랑의 숨통을 끊어야겠어
Let's kill this love
Yeah, yeah, yeah, yeah, yeah
Rum, pum, pum, pum, pum, pum, pum
Let's kill this love
Rum, pum, pum, pum, pum, pum, pum
We all commit to love
That makes you cry, oh, oh
We're all making love
That kills you inside, yeah
We must kill this love
Yeah, it's sad but true
Gotta kill this love
Before it kills you, too
Kill this love
Yeah, it's sad but true
Gotta kill this love
Gotta kill, let's kill this love
''',
      isCurrentPlaying: false,
    ),
    Song(
      title: 'BOOMBAYAH',
      author: 'BLACKPINK',
      url:
          "assets/audio/Y2meta.app - BLACKPINK - '붐바야 (BOOMBAYAH)' M_V (128 kbps).mp3",
      image:
          'https://upload.wikimedia.org/wikipedia/en/b/bf/Blackpink_-_Boombayah.jpg',
      lyrics: '''
BLACKPINK in your area
BLACKPINK in your area
천사 같은 hi 끝엔 악마 같은 bye
매번 미칠듯한 high 뒤엔 뱉어야 하는 price
이건 답이 없는 test
매번 속더라도 yes
딱한 감정의 노예
얼어 죽을 사랑해, yeah
Here I come kick in the door
Gotta go get what’s mine, I'm sorry
But I'm not sorry
내 맘대로 들어갈 거야
절대 막을 순 없지, uh
BLACK 하지 않니? 뭘 해도
Everything 뚫어지는 거야, uh
지금 너의 무엇을 해도
I'm sorry, now sorry
내가 뭐 어때서? 더럽게
생겨서 더 나쁜 놈들이 되어
또 헤벌레를 할텐데, 뱉어
그래도 살아남을 텐데
BLACKPINK (Ah-ah-ah-ah)
Ah-ah-ah-ah
BLACKPINK (Ah-ah-ah-ah)
Ah-ah-ah-ah
저 높이 뛰어들어 막을 수 없어
High 떨어져 구름 위
Keep it moving like my lease up
Think you fly, boy, where your visa?
Mona Lisa kinda Lisa
Needs an ice cream man that treats her
Keep it moving like my lease up
Think you fly, boy, where your visa?
Mona Lisa kinda Lisa
Needs an ice cream man that treats her
BLACKPINK in your area
BLACKPINK in your area
BLACKPINK in your area
불타오르네
BLACKPINK in your area
BLACKPINK in your area
BLACKPINK in your area
불타오르네
모두 내가 주인공
삐딱하게 걸친 꼭대기
가니, 그 뒤로 남긴
부분이 벌어진 새
저 높이 뛰어들어 막을 수 없어
High 떨어져 구름 위
Keep it moving like my lease up
Think you fly, boy, where your visa?
Mona Lisa kinda Lisa
Needs an ice cream man that treats her
Keep it moving like my lease up
Think you fly, boy, where your visa?
Mona Lisa kinda Lisa
Needs an ice cream man that treats her
''',
      isCurrentPlaying: false,
    ),
    Song(
      title: 'How You Like That',
      author: 'BLACKPINK',
      url:
          "assets/audio/Y2meta.app - BLACKPINK - 'How You Like That' M_V (128 kbps).mp3",
      image:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTVDDJH-1vhorW4Op-_AcUt17BRubaZad-qGQ&s',
      lyrics: '''
BLACKPINK in your area
보란 듯이 무너졌어
바닥을 뚫고 저 지하까지
옷 끝자락 잡겠다고
저 높이 두 손을 뻗어 봐도
다시 캄캄한 이곳에 light up the sky
네 두 눈을 보며, I'll kiss you goodbye
실컷 비웃어라 꼴 좋으니까
이제 너희, 하나, 둘, 셋
Ha, how you like that?
You gon' like that, that-that-that-that, that-that-that-that
How you like that? (Bada-bing, bada-boom-boom-boom)
How you like that, that-that-that-that, that-that-that-that?
Now look at you, now look at me, look at you, now look at me
Look at you, now look at me, how you like that?
Now look at you, now look at me, look at you, now look at me
Look at you, now look at me, how you like that?
Your girl need it all and that's a hunnid
백 개 중에 백, 내 몫을 원해
Karma come and get some
딱하지만 어쩔 수 없잖아
What's up? I'm right back (right back)
방아쇠를 cock back (cock back)
Plain Jane get hijacked, don't like me?
Then tell me how you like that, like that
더 캄캄한 이곳에 shine like the stars
그 미소를 띠며, I'll kiss you goodbye
실컷 비웃어라 꼴 좋으니까
이제 너희, 하나, 둘, 셋
Ha, how you like that?
You gon' like that, that-that-that-that, that-that-that-that
How you like that? (Bada-bing, bada-boom-boom-boom)
How you like that, that-that-that-that, that-that-that-that?
Now look at you, now look at me, look at you, now look at me
Look at you, now look at me, how you like that?
Now look at you, now look at me, look at you, now look at me
Look at you, now look at me, how you like that?
날개 잃은 채로 추락했던 날
어두운 나날 속에 갇혀 있던 날
그때쯤에 넌 날 끝내야 했어
Look up in the sky, it's a bird, it's a plane
Yeah-eh-eh-eh
Bring out your boss, bitch
Yeah-eh-eh-eh
BLACKPINK!
뚜뚜뚜뚜두두, 뚜뚜뚜뚜두두 (how you like that?)
뚜뚜뚜뚜두두, 뚜뚜뚜뚜두두두 (you gon' like that)
뚜뚜뚜뚜두두, 뚜뚜뚜뚜두두 (how you like that?)
뚜뚜뚜뚜두두, 뚜뚜뚜뚜두두두
''',
      isCurrentPlaying: false,
    ),
    Song(
      title: 'Pink Venom',
      author: 'BLACKPINK',
      url:
          "assets/audio/Y2meta.app - BLACKPINK - ‘Pink Venom’ M_V (128 kbps) (1).mp3",
      image:
          'https://thuamviet.com/photos/BLOG-TUYEN%20DUNG/TIN%20TUC/Pink%20venom%20blackpink/blackbink%205.png',
      lyrics: '''
Blackpink
Blackpink
Blackpink
Blackpink
Kick in the door, waving the coco'
팝콘이나 챙겨 껴들 생각 말고
I talk that talk, runways I walk-walk
눈 감고, pop-pop, 안 봐도 척
One by one, then two by two
내 손끝 툭 하나에 다 무너지는 중
가짜 쇼 치곤 화려했지
Makes no sense, you couldn't get a dollar out of me
자, 오늘 밤이야, 난 독을 품은 꽃
네 혼을 빼앗은 다음, look what you made us do
천천히 널 잠재울 fire
잔인할 만큼 아름다워 (I bring the pain like)
This that pink venom, this that pink venom
This that pink venom (get 'em, get 'em, get 'em)
Straight to ya dome like whoa-whoa-whoa
Straight to ya dome like ah-ah-ah
Taste that pink venom, taste that pink venom
Taste that pink venom (get 'em, get 'em, get 'em)
Straight to ya dome like whoa-whoa-whoa
Straight to ya dome like ah-ah-ah
Black paint and ammo', got bodies like Rambo
Rest in peace, please, light up a candle
This the life of a vandal, masked up, and I'm still in CELINE
Designer crimes, or it wouldn't be me, ooh!
Diamonds shining, drive in silence, I don't mind it, I'm riding
Flying private side by side with the pilot up in the sky
And I'm wyling, styling on them and there's no chance
'Cause we got bodies on bodies like this a slow dance
자, 오늘 밤이야, 난 독을 품은 꽃
네 혼을 빼앗은 다음, look what you made us do
천천히 널 잠재울 fire
잔인할 만큼 아름다워 (I bring the pain like)
This that pink venom, this that pink venom
This that pink venom (get 'em, get 'em, get 'em)
Straight to ya dome like whoa-whoa-whoa
Straight to ya dome like ah-ah-ah
Taste that pink venom, taste that pink venom
Taste that pink venom (get 'em, get 'em, get 'em)
Straight to ya dome like whoa-whoa-whoa
Straight to ya dome like ah-ah-ah
원한다면 provoke us
감당 못해 and you know this
이미 퍼져버린 shot that potion
네 눈앞은 핑크빛 ocean
Come and give me all the smoke
도 아니면 모 like I'm so rock and roll
Come and give me all the smoke
다 줄 세워 봐, 자, stop, drop (I bring the pain like)
라타타타, 트라타타타
라타타타, 트라타타타
라타타타, 트라타타타
Straight to ya, straight to ya, straight to ya dome like
라타타타, 트라타타타 (BLACKPINK)
라타타타, 트라타타타 (BLACKPINK)
라타타타, 트라타타타 (BLACKPINK)
I bring the pain like-
''',
      isCurrentPlaying: false,
    ),
  ];
}
