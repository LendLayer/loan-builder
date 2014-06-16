angular.module('llRisk')
  .directive('interestTable', ->
    restrict: 'E'
    replace: true
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
            <td>{{expectedDefault | number : 2}}%</td>
            <td>{{studentRate | number : 2}}%</td>
          </tr>
        </tbody>
      </table>"""
    link: (scope, iElem, iAttrs) ->
  )
