'use strict'

angular
  .module('votifiAngularApp', [
    'ngCookies',
    'ngResource',
    'ngSanitize',
    'ngRoute',
    'ngAnimate',
    'nvd3ChartDirectives',
    'ui.bootstrap',
    'jmdobry.angular-cache'
  ])
  .constant 'Globals',
    apiPrefix: '/api'
    colorBrewer: 'YlOrRd'

  .config ($routeProvider) ->
    $routeProvider
      .when '/',
        templateUrl: 'views/main.html'
        controller: 'MainCtrl'
        title: 'Overview'
      .when '/clusters',
        templateUrl: 'views/clusters.html'
        controller: 'ClustersCtrl'
        title: 'Clusters'
      .when '/nodes',
        templateUrl: 'views/nodes.html'
        controller: 'NodesCtrl'
        title: 'Nodes'
      .when '/questions',
        templateUrl: 'views/questions.html'
        controller: 'QuestionsCtrl'
        title: 'Questions'
      .when '/export',
        templateUrl: 'views/export.html'
        controller: 'ExportCtrl'
        title: 'Export'
      .otherwise
        redirectTo: '/'

  .run [
    '$rootScope',
    '$document',
    '$http',
    '$angularCacheFactory',
    ($rootScope, $document, $http, $angularCacheFactory) ->

      $angularCacheFactory 'appCache',
        maxAge: 1000 * 60 * 60 * 24
        cacheFlushInterval: 1000 * 60 * 60 * 24
        storageMode: 'localStorage'
        verifyIntegrity: true
        deleteOnExpire: 'aggressive'

      $http.defaults.cache = $angularCacheFactory.get 'cache'

      $rootScope.$on '$routeChangeSuccess', (event, current, previous) ->
        $rootScope.title = current.$$route.title
  ]