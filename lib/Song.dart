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
      title: 'Jisoo - Flower',
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
      title: 'BLACKPINK - DDU-DU DDU-DU',
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
      title: 'BLACKPINK - Kill This Love',
      author: 'BLACKPINK',
      url:
          'assets/audio/Y2meta.app - BLACKPINK - \'Kill This Love\' M_V (128 kbps).mp3',
      image:
          'https://ss-images.saostar.vn/2019/04/07/4920635/blackpink-kill-this-love-mv-2019-billboard-1548.jpg',
      lyrics: '',
      isCurrentPlaying: false,
    ),
  ];
}
