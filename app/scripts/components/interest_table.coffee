angular.module('llRisk')
  .directive('interestTable', ->
    restrict: 'E'
    replace: true
    scope:
      defaultRate: '='
      targetInterestRate: '@'
      fee: '@'
    template:
      """<table class="table table-bordered interest-table">
        <thead>
          <tr>
            <th>Target Investor Rate</th>
            <th>LendLayer Fee</th>
            <th>Expected Default</th>
            <th>Student APR</th>
          </tr>
        </thead>
        <tbody>
          <tr class="info">
            <td>{{targetInterestRate}}%</td>
            <td>{{fee}}%</td>
            <td>{{defaultRate | number : 2}}%</td>
            <td>{{studentRate() | number : 2}}%</td>
          </tr>
        </tbody>
      </table>"""
    link: (scope, iElem, iAttrs) ->
      scope.studentRate = ->
        netInterest = (+scope.targetInterestRate) + (+scope.fee)
        rate = (1 + netInterest/100) / (1 - scope.defaultRate/100)
        (rate - 1) * 100
  )
