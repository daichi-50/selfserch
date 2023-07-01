module ApplicationHelper
    def default_meta_tags(post = nil)
        {
            site: '自分、探してます',
            title: '日常の中で失ったものはありませんか？自分見失ってませんか？',
            reverse: true,
            separator: '|',
            description: '「自分、探してます」は、見失ったものに関する投稿をします。そしてみんなからコメントをもらうサービスです。',
            keywords: '自分、探してます',
            charset: 'UTF-8',
            canonical: request.original_url,
            noindex: !Rails.env.production?,
            og: {
            site_name: '自分、探してます',
            title: :title,
            description: :description,
            image: image_url("ogp.jpg"),
            type: 'website',
            url: request.original_url,
            local: 'ja-JP'
            },
            twitter: {
            card: 'summary_large_image',
            site: '@Nakano-41期生',
            image: image_url("ogp.jpg")
            }
        }
    end
end
