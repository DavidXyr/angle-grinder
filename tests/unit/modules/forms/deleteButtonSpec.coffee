describe "module: angleGrinder.forms directive: agDeleteButton", ->
  beforeEach module("angleGrinder.forms")

  element = null
  $scope = null
  $http = null

  beforeEach inject ($injector, _$http_) ->
    $http = _$http_

    {element, $scope} = compileTemplate """
      <ag-delete-button when-confirmed="delete(123)" deleting="deleting"></ag-delete-button>
    """, $injector

  it "is visible", ->
    expect(element.css("display")).not.to.equal "none"

  it "is not disabled", ->
    expect(element.prop("disabled")).to.be.false

  it "has a valid label", ->
    expect(element.text()).to.contain "Delete"

  describe "when the button is clicked", ->
    beforeEach -> element.click()

    it "displays the confirmation", ->
      expect(element.text()).to.contain "Are you sure?"

    it "changes button class", ->
      expect(element.hasClass("btn-warning")).to.be.true

  describe "when the button is double clicked", ->
    beforeEach ->
      element.click()
      $scope.delete = ->

    it "performs delete action", ->
      # Given
      spy = sinon.spy($scope, "delete")

      # When
      element.click()

      # Then
      expect(spy.called).to.be.true
      expect(spy.calledWith(123)).to.be.true

  describe "disabling / enabling", ->
    requestInProgress = (val) ->
      beforeEach inject (pendingRequests) ->
        stub = sinon.stub(pendingRequests, "for").returns(val)
        $scope.$apply()
        expect(stub.called).to.be.true
        expect(stub.calledWith("POST", "DELETE")).to.be.true

    describe "when the request is in progress", ->
      requestInProgress true

      it "disables the button", ->
        expect(element.prop("disabled")).to.be.true

      it "changes the button label", ->
        expect(element.text()).to.contain "Delete..."

    describe "when the request in not in progress", ->
      requestInProgress false

      it "is enabled", ->
        expect(element.prop("disabled")).to.be.false
