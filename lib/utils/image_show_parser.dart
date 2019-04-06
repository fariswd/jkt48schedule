import '../constant/member.dart';

String imageParser(raw) {
  switch (raw) {
    case 'Sambil Menggandeng Erat Tanganku':
      return 'https://jkt48.com/new3/img/setlist8.png';
    case 'Pajama Drive':
      return 'https://jkt48.com/new3/img/setlist1.png';
    case 'Fajar Sang Idola':
      return 'https://jkt48.com/new3/img/setlist17.png';
    case 'Saka Agari':
      return 'https://jkt48.com/new3/img/setlist16.png';
    case 'Romansa Sang Gadis':
      return 'https://jkt48.com/new3/img/setlist18.png';
    default:
      return 'https://jkt48.com/new3/img/logo.png';
  }
}

String imageLargeParser(raw) {
  switch (raw) {
    case 'Sambil Menggandeng Erat Tanganku':
      return 'https://jkt48.com/images/banner.home.smet.jpg';
    case 'Pajama Drive':
      return 'https://jkt48.com/images/banner.home.pajama.jpg';
    case 'Fajar Sang Idola':
      return 'https://jkt48.com/images/big_banner_fsi.png';
    case 'Saka Agari':
      return 'https://jkt48.com/images/banner.home.saka.jpg';
    case 'Romansa Sang Gadis':
      return 'https://jkt48.com/new3/img/setlist18.png';
    default:
      return 'https://jkt48.com/new3/img/logo.png';
  }
}

String imageTeam(raw) {
  switch (raw) {
    case 'Team T':
      return 'http://oi64.tinypic.com/33vg749.jpg';
    case 'Academy A':
      return 'http://oi64.tinypic.com/35l90go.jpg';
    case 'Team J':
      return 'http://oi64.tinypic.com/fyemow.jpg';
    case 'Team KIII':
      return 'http://oi67.tinypic.com/atns4l.jpg';
    default:
      return 'https://jkt48.com/new3/img/logo.png';
  }
}

String imageMember(name) {
  var result = memberList[name];
  if(result == null) {
    return 'http://oi65.tinypic.com/2ciyoi.jpg';
  }
  return result['image'];
}