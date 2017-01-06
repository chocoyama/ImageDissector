//
//  TestData.swift
//  ImageDissector
//
//  Created by takyokoy on 2017/01/06.
//  Copyright © 2017年 chocoyama. All rights reserved.
//

import UIKit

enum TestData {
    case gif
    case png
    case jpeg
    
    var urlString: String {
        switch self {
        case .gif: return "http://www.city.yokohama.lg.jp/kankyo/nousan/brand/hamanaranking/tamanegi.gif"
        case .png: return "http://umaihirado.jp/wp-content/uploads/ji_tamanegi.png"
        case .jpeg: return "http://livingpedia.net/wp-content/uploads/2015/06/lgf01a201312280900.jpg"
        }
    }
    
    var url: URL {
        return URL.init(string: urlString)!
    }
    
    var data: Data {
        return createImageData(from: urlString)
    }
    
    var size: CGSize {
        switch self {
        case .gif: return CGSize.init(width: 308, height: 309)
        case .png: return CGSize.init(width: 263, height: 205)
        case .jpeg: return CGSize.init(width: 1024, height: 1024)
        }
    }
    
    private func createImageData(from urlString: String) -> Data {
        return try! Data.init(contentsOf: url)
    }
    
    static var manyUrls: [URL] {
        let urlStrings = [
            "http://adf.send.microad.jp/avw.php?zoneid=7896&cb=INSERT_RANDOM_NUMBER_HERE&n=a401e6b6&ct0=INSERT_CLICKURL_HERE&snr=2",
            "http://adf.send.microad.jp/avw.php?zoneid=7892&cb=INSERT_RANDOM_NUMBER_HERE&n=aaa63a76&ct0=INSERT_CLICKURL_HERE&snr=2",
            "http://b.hatena.ne.jp/entry/image/http://vipsister23.com/archives/8631629.html",
            "http://livedoor.blogimg.jp/vipsister23/imgs/e/3/e3bb8faf.jpg",
            "http://livedoor.blogimg.jp/vipsister23/imgs/0/0/002cb727.jpg",
            "http://livedoor.blogimg.jp/vipsister23/imgs/f/a/fabcac92.jpg",
            "http://livedoor.blogimg.jp/vipsister23/imgs/4/f/4f15a0b1.jpg",
            "http://livedoor.blogimg.jp/vipsister23/imgs/7/8/78c5c143.jpg",
            "http://livedoor.blogimg.jp/vipsister23/imgs/7/f/7fc19f8f.jpg",
            "http://livedoor.blogimg.jp/vipsister23/imgs/2/8/28859214.png",
            "http://livedoor.blogimg.jp/vipsister23/imgs/f/d/fde7abfb.png",
            "",
            "http://livedoor.blogimg.jp/vipsister23/imgs/f/b/fb3c7da4.png",
            "http://livedoor.blogimg.jp/vipsister23/imgs/6/1/615d25dc.jpg",
            "http://livedoor.blogimg.jp/vipsister23/imgs/0/6/065656c7.jpg",
            "http://livedoor.blogimg.jp/vipsister23/imgs/0/f/0f4dc761.jpg",
            "http://livedoor.blogimg.jp/vipsister23/imgs/e/0/e03376ce.jpg",
            "http://livedoor.blogimg.jp/vipsister23/imgs/9/6/961bba7f.jpg",
            "http://livedoor.blogimg.jp/vipsister23/imgs/4/e/4efbd8f9.jpg",
            "http://livedoor.blogimg.jp/vipsister23/imgs/8/1/813a783d.jpg",
            "http://livedoor.blogimg.jp/vipsister23/imgs/b/0/b041ba61.jpg",
            "http://livedoor.blogimg.jp/vipsister23/imgs/7/a/7af1a701.jpg",
            "http://livedoor.blogimg.jp/vipsister23/imgs/8/4/845029af.jpg",
            "http://livedoor.blogimg.jp/vipsister23/imgs/1/f/1fb419de.jpg",
            "http://livedoor.blogimg.jp/vipsister23/imgs/b/0/b03aea1e.jpg",
            "http://livedoor.blogimg.jp/vipsister23/imgs/6/d/6de30808.jpg",
            "http://livedoor.blogimg.jp/vipsister23/imgs/6/9/69283a77.jpg",
            "http://livedoor.blogimg.jp/vipsister23/imgs/b/6/b6208b9c.jpg",
            "http://livedoor.blogimg.jp/vipsister23/imgs/5/7/575a28ef.jpg",
            "http://livedoor.blogimg.jp/vipsister23/imgs/1/c/1c0d830c.jpg",
            "http://livedoor.blogimg.jp/vipsister23/imgs/d/8/d8ca8768.jpg",
            "http://livedoor.blogimg.jp/vipsister23/imgs/8/0/8048fdc1.jpg",
            "http://livedoor.blogimg.jp/vipsister23/imgs/8/4/84369d6f.jpg",
            "http://livedoor.blogimg.jp/vipsister23/imgs/5/3/533c6768.jpg",
            "http://livedoor.blogimg.jp/vipsister23/imgs/7/d/7d63813c.jpg",
            "http://livedoor.blogimg.jp/vipsister23/imgs/e/b/ebd95cc1.jpg",
            "http://livedoor.blogimg.jp/vipsister23/imgs/7/e/7ef26bdc.jpg",
            "http://livedoor.blogimg.jp/vipsister23/imgs/b/4/b4506cac.jpg",
            "http://livedoor.blogimg.jp/vipsister23/imgs/e/3/e3236d7f.jpg",
            "http://livedoor.blogimg.jp/vipsister23/imgs/0/5/055eb8b9.jpg",
            "http://livedoor.blogimg.jp/vipsister23/imgs/1/4/14b3e1d5.jpg",
            "http://livedoor.blogimg.jp/vipsister23/imgs/5/7/57389e1b.jpg",
            "http://livedoor.blogimg.jp/vipsister23/imgs/6/2/62f4d209.jpg",
            "http://livedoor.blogimg.jp/vipsister23/imgs/5/2/52348aa7.jpg",
            "http://livedoor.blogimg.jp/vipsister23/imgs/1/e/1ee4f453.jpg",
            "http://livedoor.blogimg.jp/vipsister23/imgs/e/9/e97af18e.jpg",
            "http://livedoor.blogimg.jp/vipsister23/imgs/e/5/e5ffe6c8.jpg",
            "http://livedoor.blogimg.jp/vipsister23/imgs/2/2/22d1a135.jpg",
            "http://livedoor.blogimg.jp/vipsister23/imgs/b/6/b6baa5ae.jpg",
            "http://livedoor.blogimg.jp/vipsister23/imgs/6/8/68452c0a.jpg",
            "http://livedoor.blogimg.jp/vipsister23/imgs/c/d/cdd88bbd.jpg",
            "http://livedoor.blogimg.jp/vipsister23/imgs/c/d/cd651b99.jpg",
            "http://livedoor.blogimg.jp/vipsister23/imgs/7/3/73e07419.jpg",
            "http://livedoor.blogimg.jp/vipsister23/imgs/9/d/9dda2cd0.jpg",
            "http://livedoor.blogimg.jp/vipsister23/imgs/d/d/dd2fbfc5.jpg",
            "http://livedoor.blogimg.jp/vipsister23/imgs/1/c/1c575eee.jpg",
            "http://livedoor.blogimg.jp/vipsister23/imgs/b/8/b8959fe2.jpg",
            "http://livedoor.blogimg.jp/vipsister23/imgs/1/6/166ce36f.jpg",
            "http://livedoor.blogimg.jp/vipsister23/imgs/e/4/e462d5dd.jpg",
            "http://livedoor.blogimg.jp/vipsister23/imgs/2/7/27621cbc.jpg",
            "http://livedoor.blogimg.jp/vipsister23/imgs/a/3/a32898d0.jpg",
            "http://livedoor.blogimg.jp/vipsister23/imgs/9/8/989a3e2a.jpg",
            "http://livedoor.blogimg.jp/vipsister23/imgs/0/5/05c6f503.jpg",
            "http://livedoor.blogimg.jp/vipsister23/imgs/6/c/6c59f57f.jpg",
            "http://livedoor.blogimg.jp/vipsister23/imgs/7/5/75f853c7.jpg",
            "http://livedoor.blogimg.jp/vipsister23/imgs/6/b/6b779c8b.jpg",
            "http://livedoor.blogimg.jp/vipsister23/imgs/5/9/5944c122.jpg",
            "http://livedoor.blogimg.jp/vipsister23/imgs/7/e/7eccd6a2.jpg",
            "http://livedoor.blogimg.jp/vipsister23/imgs/6/c/6c839201.jpg",
            "http://livedoor.blogimg.jp/vipsister23/imgs/7/0/70c61790.jpg",
            "http://livedoor.blogimg.jp/vipsister23/imgs/0/8/08459db7.jpg",
            "http://livedoor.blogimg.jp/vipsister23/imgs/5/1/5164d93a.jpg",
            "http://livedoor.blogimg.jp/vipsister23/imgs/d/c/dc8c9a0a.jpg",
            "http://livedoor.blogimg.jp/vipsister23/imgs/7/8/78144d93.jpg",
            "http://livedoor.blogimg.jp/vipsister23/imgs/b/f/bf60c36f.jpg",
            "http://livedoor.blogimg.jp/vipsister23/imgs/3/9/39a8964d.jpg",
            "http://livedoor.blogimg.jp/vipsister23/imgs/6/e/6e9fa289.jpg",
            "http://livedoor.blogimg.jp/vipsister23/imgs/e/7/e718c085.jpg",
            "http://livedoor.blogimg.jp/vipsister23/imgs/1/1/11237b4e.jpg",
            "http://livedoor.blogimg.jp/vipsister23/imgs/4/c/4c6aee30.jpg",
            "http://livedoor.blogimg.jp/vipsister23/imgs/b/7/b794b681.jpg",
            "http://livedoor.blogimg.jp/vipsister23/imgs/8/4/84a5db33.jpg",
            "http://livedoor.blogimg.jp/vipsister23/imgs/8/0/80c650d2.jpg",
            "http://resize.blogsys.jp/e3ef7f2a7934fe25916d934809cebb3cb28a621f/crop1/60x60/http://livedoor.blogimg.jp/vipsister23/imgs/1/7/171688c9-s.jpg",
            "http://resize.blogsys.jp/8220ff44aaa8ff577f61de4fb6800dd4139f0417/crop1/60x60/http://livedoor.blogimg.jp/vipsister23/imgs/e/9/e99b9b5a-s.jpg",
            "http://resize.blogsys.jp/59c7ae26d099836e9d36319a4ffa1f789c3f6cf8/crop1/60x60/http://livedoor.blogimg.jp/vipsister23/imgs/c/3/c3a8945b-s.jpg",
            "http://resize.blogsys.jp/b9b009e9e462d2fb6613749ab1b09506e252f7df/crop1/60x60/http://livedoor.blogimg.jp/vipsister23/imgs/b/5/b55d3654.jpg",
            "http://resize.blogsys.jp/e87e2a44430234ad8005e3a44050636d31fe0622/crop1/60x60/http://livedoor.blogimg.jp/vipsister23/imgs/4/2/4279906b-s.jpg",
            "http://resize.blogsys.jp/80e74a6ba41328d9dc445c3e985f13b1a8bbfab6/crop1/60x60/http://livedoor.blogimg.jp/vipsister23/imgs/a/a/aa518182.jpg",
            "http://resize.blogsys.jp/0925d033c116b3bb83b652d935d5f52e1ac0b25d/crop1/60x60/http://livedoor.blogimg.jp/vipsister23/imgs/6/5/65d94d53.gif",
            "http://resize.blogsys.jp/b8462a0c7e13f8fa17b3351443e1cf8bc6ad0426/crop1/60x60/http://livedoor.blogimg.jp/vipsister23/imgs/a/1/a1aeae28.jpg",
            "http://resize.blogsys.jp/4be33657f036e40569865528e4afd41ac3d85f2e/crop1/60x60/http://livedoor.blogimg.jp/vipsister23/imgs/2/b/2bae1ffd.jpg",
            "http://resize.blogsys.jp/4cb4b97e45d83920f475db5961bce4a69d3a1bb6/crop1/60x60/http://livedoor.blogimg.jp/vipsister23/imgs/5/a/5a9b9502.png",
            "http://resize.blogsys.jp/0338237ab34975b7f5a075f0b76b1ceddf8677aa/crop1/60x60/http://livedoor.blogimg.jp/vipsister23/imgs/d/1/d1f05fc3-s.jpg",
            "http://resize.blogsys.jp/ba8b67ef13218077a2d2b93d1c688deb640eaa8b/crop1/60x60/http://livedoor.blogimg.jp/vipsister23/imgs/d/3/d3962ca4.jpg",
            "http://resize.blogsys.jp/26b452323c3a27a6f241be5df4eb018d5675a3cb/crop1/60x60/http://livedoor.blogimg.jp/vipsister23/imgs/7/7/770dadb3-s.jpg",
            "http://resize.blogsys.jp/c7438bb846cd8d250c1ecd5f91b56ff17625af6f/crop1/60x60/http://livedoor.blogimg.jp/vipsister23/imgs/3/1/31d7d4d9.gif",
            "http://resize.blogsys.jp/b94659ca22eb29539a130022e3b663f32b711faf/crop1/60x60/http://livedoor.blogimg.jp/vipsister23/imgs/3/9/399d3509.gif",
            "http://resize.blogsys.jp/48c67455424c3214daed6e116b6e11df35611b62/crop1/60x60/http://livedoor.blogimg.jp/vipsister23/imgs/e/2/e212c8db-s.jpg",
            "http://resize.blogsys.jp/ea468a99f50c08a3fb22c0469b2964a6638871ce/crop1/60x60/http://livedoor.blogimg.jp/vipsister23/imgs/c/c/cc9166e3.jpg",
            "http://resize.blogsys.jp/5b91c1f4362383562061dc3f8375bc109db6664a/crop1/60x60/http://livedoor.blogimg.jp/vipsister23/imgs/b/a/ba9436ae.jpg",
            "http://resize.blogsys.jp/7270eb580c476ea7775e06034df12d3a74632169/crop1/60x60/http://livedoor.blogimg.jp/vipsister23/imgs/3/c/3cad45f9-s.png",
            "http://chart.apis.google.com/chart?cht=qr&chs=123x123&chl=http%3A%2F%2Fvipsister23.com%2F%3F_f%3Dblogjpqr&chld=M",
            "http://livedoor.blogimg.jp/vipsister23/imgs/6/1/61841e61.png",
            "http://parts.blog.livedoor.jp/img/usr/cmn/logo_blog_premium.png",
            "http://rc5.i2i.jp/bin/img/i2i_pr1.gif",
            "http://rc5.i2i.jp/bin/img/i2i_pr2.gif",
            "http://pranking3.ziyu.net/img.php?sisterboon",
            "http://file.ziyu.net/rranking.gif",
            "http://t.blog.livedoor.jp/u.gif"
        ]
        return urlStrings.flatMap{ URL.init(string: $0) }
    }
}
