var testFlavorApp1 = {
  'title': 'Flavor Client App',
  "author": "dlxstudios",
  "website": "flavor.dlxstudios.com",
  'pages': [
    {
      'path': '/',
      '_type': 'com.flavor.page',
      'title': 'Home Page',
      'components': [
        {
          '_type': 'com.flavor.text',
          'text': '#router.nav:/page2',
        },
        {
          '_type': 'com.flavor.button',
          'onTap': '#router.nav:/page2',
          'text': '#router.nav:/page2',
        },
      ]
    },
    {
      'path': '/page2',
      '_type': 'com.flavor.page',
      'title': 'Home Page',
      // 'components': []
    }
  ],
  // 'theme': {
  //   '_type': 'com.flavor.theme',
  // },
  "plugins": [
    "settings",
    "login",
    "video",
    "file_local",
    "file_network",
    "image_cache"
  ]
};
