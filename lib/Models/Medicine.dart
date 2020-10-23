class Medicine {
  var name;
  var indication;
  var dosage;
  var comments;
  var contraindications;
  var warnings;
  var interactions;
  var pregnancy;
  var sideEffects;
  var overdose;
  var action;
  var composition;

  Medicine(
      this.name,
      this.indication,
      this.dosage,
      this.comments,
      this.contraindications,
      this.warnings,
      this.interactions,
      this.pregnancy,
      this.sideEffects,
      this.overdose,
      this.action,
      this.composition);

  String printData() {
    return this.name +
        "\n" +
        "Indications:" +
        "\n" +
        this.indication +
        "\n" +
        "Dosage:" +
        "\n" +
        this.dosage +
        "\n" +
        "Comments:" +
        "\n" +
        this.comments +
        "\n" +
        "Contraindications:" +
        "\n" +
        this.contraindications +
        "\n" +
        "Warnings:" +
        "\n" +
        this.warnings +
        "\n" +
        "Interactions: " +
        "\n" +
        this.interactions +
        "\n" +
        "Pregnancy: " +
        "\n" +
        this.pregnancy +
        "\n" +
        "Side effects: " +
        "\n" +
        this.sideEffects +
        "\n" +
        "Overdose: " +
        "\n" +
        this.overdose +
        "\n" +
        "Action: " +
        "\n" +
        this.action +
        "\n" +
        "Composition:" +
        "\n" +
        this.composition +
        "\n";
  }
}
