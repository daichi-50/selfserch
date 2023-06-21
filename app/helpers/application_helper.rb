module ApplicationHelper
    def default_meta_tags
        {
            site: '自分、探してます',
            tilte: '日常の中で失ったものはありませんか？自分見失ってませんか？',
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
            #image: url_for(post.generated_card) if post.generated_card.attached?,
            type: 'website',
            url: request.original_url,
            #image: image_url("ogp.jpg"),
            locale: 'ja_JP'
            },
            twitter: {
            card: 'summary_large_image',
            }
        }
    end
end
