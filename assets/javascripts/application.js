(function(){
  "use strict"
  angular.module("DomainNamesWatchlist", ['ngRoute'])
    .controller("DomainNameFormController", ["$http", "$scope", function($http, $scope) {
      self = this;
      var domainName;

      self.getDomainNameInfo = function(){
        var request = {
          "method": "GET",
          "url": "http://127.0.0.1:9292/domain_name_info",
          "params": {
            "domain_name": self.domainName
          }
        };
        $http(request)
          .success(function(data){
            $scope.domainNameInfo = data;
            $scope.watchListItems = null;
          });
      };

      self.addToWatchList = function(){
        var request = {
          "method": "POST",
          "url": "http://127.0.0.1:9292/watchlist",
          "headers": {'Content-Type': 'application/x-www-form-urlencoded'},
          "transformRequest": function(obj) {
              var str = [];
              for(var p in obj)
              str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
              return str.join("&");
          },
          "data": {
            "domain_name_record_id": $scope.domainNameInfo.id
          }
        };
        $http(request)
          .success(function(data){
          });
      };

      self.revealWatchList = function(){
        var request = {
          "method": "GET",
          "url": "http://127.0.0.1:9292/watchlist",
        };
        $http(request)
          .success(function(data){
            $scope.domainNameInfo = null;
            $scope.watchListItems = data.watchlist;
          });
      };
    
    }])
})();
