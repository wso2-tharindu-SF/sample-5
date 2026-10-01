// In-memory catalog data and the full/empty mode switch. No persistence, no
// other computation — service2 only serves the current mode's record set.

final Record[] fullCatalogRecords = [
    {id: 1, name: "alpha-record", score: 41},
    {id: 2, name: "beta-record", score: 17},
    {id: 3, name: "gamma-record", score: 63},
    {id: 4, name: "delta-record", score: 28},
    {id: 5, name: "epsilon-record", score: 55},
    {id: 6, name: "zeta-record", score: 12},
    {id: 7, name: "eta-record", score: 39},
    {id: 8, name: "theta-record", score: 74},
    {id: 9, name: "iota-record", score: 21},
    {id: 10, name: "kappa-record", score: 8}
];

final Record[] emptyCatalogRecords = [];

// Starts in full mode on boot.
string catalogMode = "full";

function currentCatalogRecords() returns Record[] {
    if catalogMode == "empty" {
        return emptyCatalogRecords;
    }
    return fullCatalogRecords;
}

function setCatalogMode(string newMode) {
    catalogMode = newMode;
}
