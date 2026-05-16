'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "dbef680f1c860472d708cd3f16bbe7f2",
"assets/AssetManifest.bin.json": "3ed8ae917fede679614903c82fc45cc4",
"assets/AssetManifest.json": "a51874308567d506bfec8ab04c7dc132",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/fonts/MaterialIcons-Regular.otf": "685899c1232d7199af90666a683e4b52",
"assets/lib/l10n/app_cs.arb": "925822cb549a5b3fcb2a4d2e091b4c97",
"assets/lib/l10n/app_de.arb": "78dfdc51ef60fc6048a2843eaa6b0309",
"assets/lib/l10n/app_en.arb": "021c94f4fe6b742deb15c1e22b3832d5",
"assets/lib/l10n/app_es.arb": "8677a5432d4a3999c771387b33a7ffe1",
"assets/lib/l10n/app_it.arb": "8ba120a42329603a368ee89be7d6f7f5",
"assets/lib/l10n/app_localizations.dart": "8723fa7f8d18ff5730e7d02417f62553",
"assets/lib/l10n/app_pl.arb": "bb29ced17bce9c3a529357992bb3a0bc",
"assets/lib/l10n/app_uk.arb": "d848d9ffe0770df56d016030c4d9bfb4",
"assets/lib/l10n/game_cs.arb": "45c436f2557b2a8401a5fce12b68601e",
"assets/lib/l10n/game_de.arb": "4d02e5bd555e633d110eda1baee2ea6b",
"assets/lib/l10n/game_en.arb": "3e498e6c8ec30800dcbb7a463b289f75",
"assets/lib/l10n/game_es.arb": "c4dd7bc2fe1aee917e39909fa3f1a82c",
"assets/lib/l10n/game_it.arb": "e785ab157246b362a1508a412c7d438d",
"assets/lib/l10n/game_pl.arb": "969ce656995423071620573f309e23dc",
"assets/lib/l10n/game_template.arb": "32a671385ed7f2c217f5cad4f0d71cc9",
"assets/lib/l10n/game_uk.arb": "8da2514f3a578761999ca683bd77b880",
"assets/media/door-1.png": "d9df15593bb2b16322039939efbd0ad9",
"assets/media/door-2.png": "b45e87df8fbb5dbb885523c8f1590bf9",
"assets/media/door-3.png": "a30025d3f6f637f78b0bfb75a468b7ae",
"assets/media/door-4.png": "eebc4a6862d461a37455ee911e242712",
"assets/media/man-1.png": "e6ac72b2feae37f965321e1da9cb8339",
"assets/media/man-2.png": "e3645ee4997cd2f684c816160f4e7e9e",
"assets/media/man-3.png": "6cdffd2edfab6dd8d7f462f7d5dd05d2",
"assets/media/man-4.png": "eb8e97b0ebd97b7bde4e104adf363270",
"assets/media/pissoir-1-light.png": "50dbaab0160f13e06f3687a5e9f93513",
"assets/media/pissoir-2-light.png": "9ab1ee6855711083d3295f09ce86c959",
"assets/media/pissoir-3-light.png": "c76c414859a5e153617df79d7e429e21",
"assets/media/pissoir-4-light.png": "59af0fab82286331a505979b6835d1c7",
"assets/media/pissoir-5-light.png": "937c10ff8a1408f2cefee955c620ebb5",
"assets/media/wall-1.png": "dcfcfbfe49819a6480648576c20bba02",
"assets/media/wall-2.png": "3fea097541a2896423cebebd1774cb33",
"assets/media/wall-3.png": "94efcee6766292b251e340aa59ca2eb9",
"assets/media/wall-4.png": "04b9b1bcf2c75cacaf874fefaba2e4f9",
"assets/media/wall-dark.png": "6c79380eb8dc543dfb529b3d2716b803",
"assets/media/wall-light.png": "498bc8249a8cc9c86e0ce9cf71d7eeb1",
"assets/NOTICES": "4884a0be087bb2603c91fe294b32e25b",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "140ccb7d34d0a55065fbd422b843add6",
"canvaskit/canvaskit.js.symbols": "58832fbed59e00d2190aa295c4d70360",
"canvaskit/canvaskit.wasm": "07b9f5853202304d3b0749d9306573cc",
"canvaskit/chromium/canvaskit.js": "5e27aae346eee469027c80af0751d53d",
"canvaskit/chromium/canvaskit.js.symbols": "193deaca1a1424049326d4a91ad1d88d",
"canvaskit/chromium/canvaskit.wasm": "24c77e750a7fa6d474198905249ff506",
"canvaskit/skwasm.js": "1ef3ea3a0fec4569e5d531da25f34095",
"canvaskit/skwasm.js.symbols": "0088242d10d7e7d6d2649d1fe1bda7c1",
"canvaskit/skwasm.wasm": "264db41426307cfc7fa44b95a7772109",
"canvaskit/skwasm_heavy.js": "413f5b2b2d9345f37de148e2544f584f",
"canvaskit/skwasm_heavy.js.symbols": "3c01ec03b5de6d62c34e17014d1decd3",
"canvaskit/skwasm_heavy.wasm": "8034ad26ba2485dab2fd49bdd786837b",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "888483df48293866f9f41d3d9274a779",
"flutter_bootstrap.js": "c49086c9294c65002a8a15950bff9dde",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "50d38402194496d10057af2a4b43c969",
"/": "50d38402194496d10057af2a4b43c969",
"main.dart.js": "3482022f988c4b51a6ee626a82d05e2b",
"manifest.json": "608a722d198c8409b834bb7adfc1e11f",
"version.json": "c88f16a2ca213fa61162045aba094aa3"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
