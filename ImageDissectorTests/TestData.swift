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
    case heavyGif
    case png
    case jpeg
    
    var urlString: String {
        switch self {
        case .gif: return "http://www.city.yokohama.lg.jp/kankyo/nousan/brand/hamanaranking/tamanegi.gif"
        case .heavyGif: return "http://livedoor.blogimg.jp/vipsister23/imgs/2/1/210f163b.gif"
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
        case .heavyGif: return CGSize.init(width: 160, height: 176)
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
            "http://b.hatena.ne.jp/entry/image/http://vipsister23.com/archives/8701150.html",
            "http://livedoor.blogimg.jp/vipsister23/imgs/c/4/c4bc7051.gif",
            "http://livedoor.blogimg.jp/vipsister23/imgs/a/7/a75ab11c.jpg",
            "http://livedoor.blogimg.jp/vipsister23/imgs/f/8/f88d3ee3.png",
            "http://img.nipple-img.com/wp-content/uploads/2016/12/02002.gif",
            "http://livedoor.blogimg.jp/vipsister23/imgs/c/4/c4f7d625.png",
            "http://livedoor.blogimg.jp/vipsister23/imgs/4/4/44cc7f65-s.jpg",
            "http://livedoor.blogimg.jp/vipsister23/imgs/c/c/cc7cfd05.gif",
            "http://livedoor.blogimg.jp/vipsister23/imgs/4/0/404c9938-s.jpg",
            "http://livedoor.blogimg.jp/vipsister23/imgs/e/0/e0c8d297.jpg",
            "http://livedoor.blogimg.jp/vipsister23/imgs/7/5/754c79bc-s.jpg",
            "http://livedoor.blogimg.jp/vipsister23/imgs/5/a/5ad63b2b-s.jpg",
            "http://livedoor.blogimg.jp/vipsister23/imgs/5/1/51de358b.jpg",
            "http://livedoor.blogimg.jp/vipsister23/imgs/a/5/a5c5ba86-s.jpg",
            "http://livedoor.blogimg.jp/vipsister23/imgs/8/9/89820be7-s.jpg",
            "http://livedoor.blogimg.jp/vipsister23/imgs/6/d/6d12a70f-s.jpg",
            "http://livedoor.blogimg.jp/vipsister23/imgs/5/c/5c5fb18c-s.jpg",
            "http://livedoor.blogimg.jp/vipsister23/imgs/a/a/aa49bdf2.jpg",
            "http://livedoor.blogimg.jp/vipsister23/imgs/7/9/7953d986-s.jpg",
            "http://livedoor.blogimg.jp/vipsister23/imgs/3/b/3b8193b8-s.jpg",
            "http://livedoor.blogimg.jp/vipsister23/imgs/7/9/7939403d.jpg",
            "http://livedoor.blogimg.jp/vipsister23/imgs/6/2/62e56be7-s.jpg",
            "http://livedoor.blogimg.jp/vipsister23/imgs/4/2/4228d6d1-s.jpg",
            "http://livedoor.blogimg.jp/vipsister23/imgs/1/e/1e29f94a-s.jpg",
            "http://livedoor.blogimg.jp/vipsister23/imgs/2/1/210f163b.gif",
            "http://livedoor.blogimg.jp/vipsister23/imgs/a/c/ac250bf8.gif",
            "http://livedoor.blogimg.jp/vipsister23/imgs/f/5/f5ccad35.gif",
            "http://livedoor.blogimg.jp/vipsister23/imgs/f/2/f2fea007.gif",
            "http://livedoor.blogimg.jp/vipsister23/imgs/2/e/2ee3ed88-s.jpg",
            "http://livedoor.blogimg.jp/vipsister23/imgs/4/8/48589ceb-s.jpg",
            "http://livedoor.blogimg.jp/vipsister23/imgs/1/e/1edf81c8.gif",
            "http://livedoor.blogimg.jp/vipsister23/imgs/3/2/3283f332-s.jpg",
            "http://livedoor.blogimg.jp/vipsister23/imgs/6/3/63f4e42b-s.jpg",
            "http://livedoor.blogimg.jp/vipsister23/imgs/9/4/9477af29.jpg",
            "http://livedoor.blogimg.jp/vipsister23/imgs/a/4/a4fe324e-s.jpg",
            "http://livedoor.blogimg.jp/vipsister23/imgs/0/a/0ab1f85f-s.jpg",
            "http://livedoor.blogimg.jp/vipsister23/imgs/5/a/5a68c76a-s.jpg",
            "http://livedoor.blogimg.jp/vipsister23/imgs/8/1/81501c93-s.jpg",
            "http://livedoor.blogimg.jp/vipsister23/imgs/0/8/08bd0b78.gif",
            "http://livedoor.blogimg.jp/vipsister23/imgs/7/1/7152e3d7.jpg",
            "http://livedoor.blogimg.jp/vipsister23/imgs/1/3/13e81aa5.jpg",
            "http://livedoor.blogimg.jp/vipsister23/imgs/0/8/08593e3c.jpg",
            "http://livedoor.blogimg.jp/vipsister23/imgs/8/1/815c4ca8.jpg",
            "http://livedoor.blogimg.jp/vipsister23/imgs/3/c/3ce22dc2.jpg",
            "http://resize.blogsys.jp/c312667b167bf59d09d5a72a6e59d318bc249207/crop1/60x60/http://livedoor.blogimg.jp/vipsister23/imgs/2/5/256f6595-s.jpg",
            "http://resize.blogsys.jp/a933d7d6d2e0f5ae075f8b5855b33134e0c2682d/crop1/60x60/http://livedoor.blogimg.jp/vipsister23/imgs/b/e/beea3b7b.jpg",
            "http://resize.blogsys.jp/e5d33630fecc869971aa5fef331b8a656a2009b0/crop1/60x60/http://livedoor.blogimg.jp/vipsister23/imgs/0/9/09a69e8e-s.jpg",
            "http://resize.blogsys.jp/c03cf6b66bfb3df5dae2ba55943e74909da7e798/crop1/60x60/http://livedoor.blogimg.jp/vipsister23/imgs/c/4/c4bc7051.gif",
            "http://resize.blogsys.jp/34ca3b2fe6d4a7e4ae9ed47786f023901be6abf9/crop1/60x60/http://livedoor.blogimg.jp/vipsister23/imgs/e/b/ebe2b079.jpg",
            "http://resize.blogsys.jp/3e235194df6a3eb11a8591596a4096ab061280d1/crop1/60x60/http://livedoor.blogimg.jp/vipsister23/imgs/7/1/713f7f2a-s.jpg",
            "http://resize.blogsys.jp/db1873af76e6f0c3e7485e13c50168f3f331dfc9/crop1/60x60/http://livedoor.blogimg.jp/vipsister23/imgs/7/5/7547f527-s.jpg",
            "http://resize.blogsys.jp/a7c5c70df9bd1c3e047283b752f4134b7937953c/crop1/60x60/http://livedoor.blogimg.jp/vipsister23/imgs/8/9/89bc1ad1-s.jpg",
            "http://resize.blogsys.jp/257151c6f54ee6b3ed155b458421136e13b15501/crop1/60x60/http://livedoor.blogimg.jp/vipsister23/imgs/b/a/ba08a5bf-s.jpg",
            "http://resize.blogsys.jp/be80e6469150156502062de6acd5759bb7f443bc/crop1/60x60/http://livedoor.blogimg.jp/vipsister23/imgs/4/9/49205f03-s.jpg",
            "http://resize.blogsys.jp/b6f12f38fd04f9de02131a1c99c35444baef0027/crop1/60x60/http://livedoor.blogimg.jp/vipsister23/imgs/9/0/90d7d65f-s.jpg",
            "http://resize.blogsys.jp/9921beab2e222e18c6f38c871f23eeda3ab75826/crop1/60x60/http://livedoor.blogimg.jp/vipsister23/imgs/0/2/027463d0.gif",
            "http://resize.blogsys.jp/fa27c56e24cb37fee3a66c09840ffcd4602b9232/crop1/60x60/http://livedoor.blogimg.jp/vipsister23/imgs/b/a/ba920182.jpg",
            "http://resize.blogsys.jp/797f7de7e77a2d7fffc9b4d25987c8c5411daf7e/crop1/60x60/http://livedoor.blogimg.jp/vipsister23/imgs/5/c/5cd94f89.jpg",
            "http://resize.blogsys.jp/6eeb0b2d30eae98e1b95c0f058ea6547e1cf297f/crop1/60x60/http://livedoor.blogimg.jp/vipsister23/imgs/c/c/cc08f782-s.jpg",
            "http://resize.blogsys.jp/f99b6abb44100768532a6aba87ead24fdbc91390/crop1/60x60/http://livedoor.blogimg.jp/vipsister23/imgs/9/b/9b35076d.png",
            "http://resize.blogsys.jp/fe25a3bdb5484752a54608bb37f45336702f0115/crop1/60x60/http://livedoor.blogimg.jp/vipsister23/imgs/9/8/98697065.jpg",
            "http://resize.blogsys.jp/545d035a9bb6beac84b20adf169fd444c4262bd7/crop1/60x60/http://livedoor.blogimg.jp/vipsister23/imgs/0/1/017a8c47-s.jpg",
            "http://chart.apis.google.com/chart?cht=qr&chs=123x123&chl=http%3A%2F%2Fvipsister23.com%2F%3F_f%3Dblogjpqr&chld=M",
            "http://livedoor.blogimg.jp/vipsister23/imgs/6/1/61841e61.png",
            "http://parts.blog.livedoor.jp/img/usr/cmn/logo_blog_premium.png",
            "http://rc5.i2i.jp/bin/img/i2i_pr1.gif",
            "http://rc5.i2i.jp/bin/img/i2i_pr2.gif",
            "http://pranking3.ziyu.net/img.php?sisterboon",
            "http://file.ziyu.net/rranking.gif",
            "http://t.blog.livedoor.jp/u.gif",
        ]
        return urlStrings.flatMap{ URL.init(string: $0) }
    }
}
