" プラグインが読み込まれていない場合何もせず終了する
UsePlugin 'vim-textobj-user'

" 全角括弧をテキストオブジェクトとして扱えるようにする
call textobj#user#plugin('jabraces', {
\      'kagi-kakko': {
\         '*pattern*': ["\u300C", "\u300D"],
\         'select-a': 'ajk',
\         'select-i': 'ijk'
\      },
\    })

