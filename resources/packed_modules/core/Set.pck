{
  "header": {
    "name": "Set",
    "exposing": {
      "Just": [
        {
          "Type": "Set"
        },
        {
          "Definition": "empty"
        },
        {
          "Definition": "singleton"
        },
        {
          "Definition": "insert"
        },
        {
          "Definition": "remove"
        },
        {
          "Definition": "isEmpty"
        },
        {
          "Definition": "member"
        },
        {
          "Definition": "size"
        },
        {
          "Definition": "union"
        },
        {
          "Definition": "intersect"
        },
        {
          "Definition": "diff"
        },
        {
          "Definition": "toList"
        },
        {
          "Definition": "fromList"
        },
        {
          "Definition": "map"
        },
        {
          "Definition": "foldl"
        },
        {
          "Definition": "foldr"
        },
        {
          "Definition": "filter"
        },
        {
          "Definition": "partition"
        }
      ]
    }
  },
  "imports": [
    {
      "path": [
        "Basics"
      ],
      "alias": null,
      "exposing": {
        "Just": [
          {
            "Type": "Bool"
          },
          {
            "Type": "Int"
          }
        ]
      }
    },
    {
      "path": [
        "Dict"
      ],
      "alias": null,
      "exposing": null
    },
    {
      "path": [
        "List"
      ],
      "alias": null,
      "exposing": {
        "Just": [
          {
            "BinaryOperator": "::"
          }
        ]
      }
    },
    {
      "path": [
        "Maybe"
      ],
      "alias": null,
      "exposing": {
        "Just": [
          {
            "Adt": [
              "Maybe",
              "All"
            ]
          }
        ]
      }
    }
  ],
  "statements": [
    {
      "Adt": [
        "Set",
        [
          "t"
        ],
        [
          [
            "Set_elm_builtin",
            [
              {
                "Tag": [
                  "Dict.Dict",
                  [
                    {
                      "Var": "t"
                    },
                    "Unit"
                  ]
                ]
              }
            ]
          ]
        ]
      ]
    },
    {
      "Def": {
        "header": {
          "Tag": [
            "Set",
            [
              {
                "Var": "a"
              }
            ]
          ]
        },
        "name": "empty",
        "patterns": [],
        "expr": {
          "Application": [
            [
              980,
              1006
            ],
            {
              "Ref": [
                [
                  980,
                  996
                ],
                "Set_elm_builtin"
              ]
            },
            {
              "QualifiedRef": [
                [
                  996,
                  1006
                ],
                [
                  "Dict"
                ],
                "empty"
              ]
            }
          ]
        }
      }
    },
    {
      "Def": {
        "header": {
          "Fun": [
            {
              "Var": "comparable"
            },
            {
              "Tag": [
                "Set",
                [
                  {
                    "Var": "comparable"
                  }
                ]
              ]
            }
          ]
        },
        "name": "singleton",
        "patterns": [
          {
            "Var": "key"
          }
        ],
        "expr": {
          "Application": [
            [
              1104,
              1143
            ],
            {
              "Ref": [
                [
                  1104,
                  1120
                ],
                "Set_elm_builtin"
              ]
            },
            {
              "Application": [
                [
                  1121,
                  1142
                ],
                {
                  "Application": [
                    [
                      1121,
                      1142
                    ],
                    {
                      "QualifiedRef": [
                        [
                          1121,
                          1136
                        ],
                        [
                          "Dict"
                        ],
                        "singleton"
                      ]
                    },
                    {
                      "Ref": [
                        [
                          1136,
                          1139
                        ],
                        "key"
                      ]
                    }
                  ]
                },
                {
                  "Unit": [
                    1140,
                    1142
                  ]
                }
              ]
            }
          ]
        }
      }
    },
    {
      "Def": {
        "header": {
          "Fun": [
            {
              "Var": "comparable"
            },
            {
              "Fun": [
                {
                  "Tag": [
                    "Set",
                    [
                      {
                        "Var": "comparable"
                      }
                    ]
                  ]
                },
                {
                  "Tag": [
                    "Set",
                    [
                      {
                        "Var": "comparable"
                      }
                    ]
                  ]
                }
              ]
            }
          ]
        },
        "name": "insert",
        "patterns": [
          {
            "Var": "key"
          },
          {
            "Adt": [
              "Set_elm_builtin",
              [
                {
                  "Var": "dict"
                }
              ]
            ]
          }
        ],
        "expr": {
          "Application": [
            [
              1274,
              1315
            ],
            {
              "Ref": [
                [
                  1274,
                  1290
                ],
                "Set_elm_builtin"
              ]
            },
            {
              "Application": [
                [
                  1291,
                  1314
                ],
                {
                  "Application": [
                    [
                      1291,
                      1314
                    ],
                    {
                      "Application": [
                        [
                          1291,
                          1314
                        ],
                        {
                          "QualifiedRef": [
                            [
                              1291,
                              1303
                            ],
                            [
                              "Dict"
                            ],
                            "insert"
                          ]
                        },
                        {
                          "Ref": [
                            [
                              1303,
                              1306
                            ],
                            "key"
                          ]
                        }
                      ]
                    },
                    {
                      "Unit": [
                        1307,
                        1310
                      ]
                    }
                  ]
                },
                {
                  "Ref": [
                    [
                      1310,
                      1314
                    ],
                    "dict"
                  ]
                }
              ]
            }
          ]
        }
      }
    },
    {
      "Def": {
        "header": {
          "Fun": [
            {
              "Var": "comparable"
            },
            {
              "Fun": [
                {
                  "Tag": [
                    "Set",
                    [
                      {
                        "Var": "comparable"
                      }
                    ]
                  ]
                },
                {
                  "Tag": [
                    "Set",
                    [
                      {
                        "Var": "comparable"
                      }
                    ]
                  ]
                }
              ]
            }
          ]
        },
        "name": "remove",
        "patterns": [
          {
            "Var": "key"
          },
          {
            "Adt": [
              "Set_elm_builtin",
              [
                {
                  "Var": "dict"
                }
              ]
            ]
          }
        ],
        "expr": {
          "Application": [
            [
              1494,
              1532
            ],
            {
              "Ref": [
                [
                  1494,
                  1510
                ],
                "Set_elm_builtin"
              ]
            },
            {
              "Application": [
                [
                  1511,
                  1531
                ],
                {
                  "Application": [
                    [
                      1511,
                      1531
                    ],
                    {
                      "QualifiedRef": [
                        [
                          1511,
                          1523
                        ],
                        [
                          "Dict"
                        ],
                        "remove"
                      ]
                    },
                    {
                      "Ref": [
                        [
                          1523,
                          1526
                        ],
                        "key"
                      ]
                    }
                  ]
                },
                {
                  "Ref": [
                    [
                      1527,
                      1531
                    ],
                    "dict"
                  ]
                }
              ]
            }
          ]
        }
      }
    },
    {
      "Def": {
        "header": {
          "Fun": [
            {
              "Tag": [
                "Set",
                [
                  {
                    "Var": "a"
                  }
                ]
              ]
            },
            {
              "Tag": [
                "Bool",
                []
              ]
            }
          ]
        },
        "name": "isEmpty",
        "patterns": [
          {
            "Adt": [
              "Set_elm_builtin",
              [
                {
                  "Var": "dict"
                }
              ]
            ]
          }
        ],
        "expr": {
          "Application": [
            [
              1630,
              1647
            ],
            {
              "QualifiedRef": [
                [
                  1630,
                  1643
                ],
                [
                  "Dict"
                ],
                "isEmpty"
              ]
            },
            {
              "Ref": [
                [
                  1643,
                  1647
                ],
                "dict"
              ]
            }
          ]
        }
      }
    },
    {
      "Def": {
        "header": {
          "Fun": [
            {
              "Var": "comparable"
            },
            {
              "Fun": [
                {
                  "Tag": [
                    "Set",
                    [
                      {
                        "Var": "comparable"
                      }
                    ]
                  ]
                },
                {
                  "Tag": [
                    "Bool",
                    []
                  ]
                }
              ]
            }
          ]
        },
        "name": "member",
        "patterns": [
          {
            "Var": "key"
          },
          {
            "Adt": [
              "Set_elm_builtin",
              [
                {
                  "Var": "dict"
                }
              ]
            ]
          }
        ],
        "expr": {
          "Application": [
            [
              1775,
              1795
            ],
            {
              "Application": [
                [
                  1775,
                  1795
                ],
                {
                  "QualifiedRef": [
                    [
                      1775,
                      1787
                    ],
                    [
                      "Dict"
                    ],
                    "member"
                  ]
                },
                {
                  "Ref": [
                    [
                      1787,
                      1790
                    ],
                    "key"
                  ]
                }
              ]
            },
            {
              "Ref": [
                [
                  1791,
                  1795
                ],
                "dict"
              ]
            }
          ]
        }
      }
    },
    {
      "Def": {
        "header": {
          "Fun": [
            {
              "Tag": [
                "Set",
                [
                  {
                    "Var": "a"
                  }
                ]
              ]
            },
            {
              "Tag": [
                "Int",
                []
              ]
            }
          ]
        },
        "name": "size",
        "patterns": [
          {
            "Adt": [
              "Set_elm_builtin",
              [
                {
                  "Var": "dict"
                }
              ]
            ]
          }
        ],
        "expr": {
          "Application": [
            [
              1900,
              1914
            ],
            {
              "QualifiedRef": [
                [
                  1900,
                  1910
                ],
                [
                  "Dict"
                ],
                "size"
              ]
            },
            {
              "Ref": [
                [
                  1910,
                  1914
                ],
                "dict"
              ]
            }
          ]
        }
      }
    },
    {
      "Def": {
        "header": {
          "Fun": [
            {
              "Tag": [
                "Set",
                [
                  {
                    "Var": "comparable"
                  }
                ]
              ]
            },
            {
              "Fun": [
                {
                  "Tag": [
                    "Set",
                    [
                      {
                        "Var": "comparable"
                      }
                    ]
                  ]
                },
                {
                  "Tag": [
                    "Set",
                    [
                      {
                        "Var": "comparable"
                      }
                    ]
                  ]
                }
              ]
            }
          ]
        },
        "name": "union",
        "patterns": [
          {
            "Adt": [
              "Set_elm_builtin",
              [
                {
                  "Var": "dict1"
                }
              ]
            ]
          },
          {
            "Adt": [
              "Set_elm_builtin",
              [
                {
                  "Var": "dict2"
                }
              ]
            ]
          }
        ],
        "expr": {
          "Application": [
            [
              2085,
              2125
            ],
            {
              "Ref": [
                [
                  2085,
                  2101
                ],
                "Set_elm_builtin"
              ]
            },
            {
              "Application": [
                [
                  2102,
                  2124
                ],
                {
                  "Application": [
                    [
                      2102,
                      2124
                    ],
                    {
                      "QualifiedRef": [
                        [
                          2102,
                          2113
                        ],
                        [
                          "Dict"
                        ],
                        "union"
                      ]
                    },
                    {
                      "Ref": [
                        [
                          2113,
                          2118
                        ],
                        "dict1"
                      ]
                    }
                  ]
                },
                {
                  "Ref": [
                    [
                      2119,
                      2124
                    ],
                    "dict2"
                  ]
                }
              ]
            }
          ]
        }
      }
    },
    {
      "Def": {
        "header": {
          "Fun": [
            {
              "Tag": [
                "Set",
                [
                  {
                    "Var": "comparable"
                  }
                ]
              ]
            },
            {
              "Fun": [
                {
                  "Tag": [
                    "Set",
                    [
                      {
                        "Var": "comparable"
                      }
                    ]
                  ]
                },
                {
                  "Tag": [
                    "Set",
                    [
                      {
                        "Var": "comparable"
                      }
                    ]
                  ]
                }
              ]
            }
          ]
        },
        "name": "intersect",
        "patterns": [
          {
            "Adt": [
              "Set_elm_builtin",
              [
                {
                  "Var": "dict1"
                }
              ]
            ]
          },
          {
            "Adt": [
              "Set_elm_builtin",
              [
                {
                  "Var": "dict2"
                }
              ]
            ]
          }
        ],
        "expr": {
          "Application": [
            [
              2333,
              2377
            ],
            {
              "Ref": [
                [
                  2333,
                  2349
                ],
                "Set_elm_builtin"
              ]
            },
            {
              "Application": [
                [
                  2350,
                  2376
                ],
                {
                  "Application": [
                    [
                      2350,
                      2376
                    ],
                    {
                      "QualifiedRef": [
                        [
                          2350,
                          2365
                        ],
                        [
                          "Dict"
                        ],
                        "intersect"
                      ]
                    },
                    {
                      "Ref": [
                        [
                          2365,
                          2370
                        ],
                        "dict1"
                      ]
                    }
                  ]
                },
                {
                  "Ref": [
                    [
                      2371,
                      2376
                    ],
                    "dict2"
                  ]
                }
              ]
            }
          ]
        }
      }
    },
    {
      "Def": {
        "header": {
          "Fun": [
            {
              "Tag": [
                "Set",
                [
                  {
                    "Var": "comparable"
                  }
                ]
              ]
            },
            {
              "Fun": [
                {
                  "Tag": [
                    "Set",
                    [
                      {
                        "Var": "comparable"
                      }
                    ]
                  ]
                },
                {
                  "Tag": [
                    "Set",
                    [
                      {
                        "Var": "comparable"
                      }
                    ]
                  ]
                }
              ]
            }
          ]
        },
        "name": "diff",
        "patterns": [
          {
            "Adt": [
              "Set_elm_builtin",
              [
                {
                  "Var": "dict1"
                }
              ]
            ]
          },
          {
            "Adt": [
              "Set_elm_builtin",
              [
                {
                  "Var": "dict2"
                }
              ]
            ]
          }
        ],
        "expr": {
          "Application": [
            [
              2610,
              2649
            ],
            {
              "Ref": [
                [
                  2610,
                  2626
                ],
                "Set_elm_builtin"
              ]
            },
            {
              "Application": [
                [
                  2627,
                  2648
                ],
                {
                  "Application": [
                    [
                      2627,
                      2648
                    ],
                    {
                      "QualifiedRef": [
                        [
                          2627,
                          2637
                        ],
                        [
                          "Dict"
                        ],
                        "diff"
                      ]
                    },
                    {
                      "Ref": [
                        [
                          2637,
                          2642
                        ],
                        "dict1"
                      ]
                    }
                  ]
                },
                {
                  "Ref": [
                    [
                      2643,
                      2648
                    ],
                    "dict2"
                  ]
                }
              ]
            }
          ]
        }
      }
    },
    {
      "Def": {
        "header": {
          "Fun": [
            {
              "Tag": [
                "Set",
                [
                  {
                    "Var": "a"
                  }
                ]
              ]
            },
            {
              "Tag": [
                "List",
                [
                  {
                    "Var": "a"
                  }
                ]
              ]
            }
          ]
        },
        "name": "toList",
        "patterns": [
          {
            "Adt": [
              "Set_elm_builtin",
              [
                {
                  "Var": "dict"
                }
              ]
            ]
          }
        ],
        "expr": {
          "Application": [
            [
              2776,
              2790
            ],
            {
              "QualifiedRef": [
                [
                  2776,
                  2786
                ],
                [
                  "Dict"
                ],
                "keys"
              ]
            },
            {
              "Ref": [
                [
                  2786,
                  2790
                ],
                "dict"
              ]
            }
          ]
        }
      }
    },
    {
      "Def": {
        "header": {
          "Fun": [
            {
              "Tag": [
                "List",
                [
                  {
                    "Var": "comparable"
                  }
                ]
              ]
            },
            {
              "Tag": [
                "Set",
                [
                  {
                    "Var": "comparable"
                  }
                ]
              ]
            }
          ]
        },
        "name": "fromList",
        "patterns": [
          {
            "Var": "list"
          }
        ],
        "expr": {
          "Application": [
            [
              2915,
              2943
            ],
            {
              "Application": [
                [
                  2915,
                  2943
                ],
                {
                  "Application": [
                    [
                      2915,
                      2943
                    ],
                    {
                      "QualifiedRef": [
                        [
                          2915,
                          2926
                        ],
                        [
                          "List"
                        ],
                        "foldl"
                      ]
                    },
                    {
                      "Ref": [
                        [
                          2926,
                          2932
                        ],
                        "insert"
                      ]
                    }
                  ]
                },
                {
                  "Ref": [
                    [
                      2933,
                      2938
                    ],
                    "empty"
                  ]
                }
              ]
            },
            {
              "Ref": [
                [
                  2939,
                  2943
                ],
                "list"
              ]
            }
          ]
        }
      }
    },
    {
      "Def": {
        "header": {
          "Fun": [
            {
              "Fun": [
                {
                  "Var": "a"
                },
                {
                  "Fun": [
                    {
                      "Var": "b"
                    },
                    {
                      "Var": "b"
                    }
                  ]
                }
              ]
            },
            {
              "Fun": [
                {
                  "Var": "b"
                },
                {
                  "Fun": [
                    {
                      "Tag": [
                        "Set",
                        [
                          {
                            "Var": "a"
                          }
                        ]
                      ]
                    },
                    {
                      "Var": "b"
                    }
                  ]
                }
              ]
            }
          ]
        },
        "name": "foldl",
        "patterns": [
          {
            "Var": "func"
          },
          {
            "Var": "initialState"
          },
          {
            "Adt": [
              "Set_elm_builtin",
              [
                {
                  "Var": "dict"
                }
              ]
            ]
          }
        ],
        "expr": {
          "Application": [
            [
              3109,
              3170
            ],
            {
              "Application": [
                [
                  3109,
                  3170
                ],
                {
                  "Application": [
                    [
                      3109,
                      3170
                    ],
                    {
                      "QualifiedRef": [
                        [
                          3109,
                          3120
                        ],
                        [
                          "Dict"
                        ],
                        "foldl"
                      ]
                    },
                    {
                      "Lambda": [
                        [
                          3121,
                          3151
                        ],
                        [
                          {
                            "Var": "key"
                          },
                          "Wildcard",
                          {
                            "Var": "state"
                          }
                        ],
                        {
                          "Application": [
                            [
                              3137,
                              3151
                            ],
                            {
                              "Application": [
                                [
                                  3137,
                                  3151
                                ],
                                {
                                  "Ref": [
                                    [
                                      3137,
                                      3141
                                    ],
                                    "func"
                                  ]
                                },
                                {
                                  "Ref": [
                                    [
                                      3142,
                                      3145
                                    ],
                                    "key"
                                  ]
                                }
                              ]
                            },
                            {
                              "Ref": [
                                [
                                  3146,
                                  3151
                                ],
                                "state"
                              ]
                            }
                          ]
                        }
                      ]
                    }
                  ]
                },
                {
                  "Ref": [
                    [
                      3153,
                      3165
                    ],
                    "initialState"
                  ]
                }
              ]
            },
            {
              "Ref": [
                [
                  3166,
                  3170
                ],
                "dict"
              ]
            }
          ]
        }
      }
    },
    {
      "Def": {
        "header": {
          "Fun": [
            {
              "Fun": [
                {
                  "Var": "a"
                },
                {
                  "Fun": [
                    {
                      "Var": "b"
                    },
                    {
                      "Var": "b"
                    }
                  ]
                }
              ]
            },
            {
              "Fun": [
                {
                  "Var": "b"
                },
                {
                  "Fun": [
                    {
                      "Tag": [
                        "Set",
                        [
                          {
                            "Var": "a"
                          }
                        ]
                      ]
                    },
                    {
                      "Var": "b"
                    }
                  ]
                }
              ]
            }
          ]
        },
        "name": "foldr",
        "patterns": [
          {
            "Var": "func"
          },
          {
            "Var": "initialState"
          },
          {
            "Adt": [
              "Set_elm_builtin",
              [
                {
                  "Var": "dict"
                }
              ]
            ]
          }
        ],
        "expr": {
          "Application": [
            [
              3336,
              3397
            ],
            {
              "Application": [
                [
                  3336,
                  3397
                ],
                {
                  "Application": [
                    [
                      3336,
                      3397
                    ],
                    {
                      "QualifiedRef": [
                        [
                          3336,
                          3347
                        ],
                        [
                          "Dict"
                        ],
                        "foldr"
                      ]
                    },
                    {
                      "Lambda": [
                        [
                          3348,
                          3378
                        ],
                        [
                          {
                            "Var": "key"
                          },
                          "Wildcard",
                          {
                            "Var": "state"
                          }
                        ],
                        {
                          "Application": [
                            [
                              3364,
                              3378
                            ],
                            {
                              "Application": [
                                [
                                  3364,
                                  3378
                                ],
                                {
                                  "Ref": [
                                    [
                                      3364,
                                      3368
                                    ],
                                    "func"
                                  ]
                                },
                                {
                                  "Ref": [
                                    [
                                      3369,
                                      3372
                                    ],
                                    "key"
                                  ]
                                }
                              ]
                            },
                            {
                              "Ref": [
                                [
                                  3373,
                                  3378
                                ],
                                "state"
                              ]
                            }
                          ]
                        }
                      ]
                    }
                  ]
                },
                {
                  "Ref": [
                    [
                      3380,
                      3392
                    ],
                    "initialState"
                  ]
                }
              ]
            },
            {
              "Ref": [
                [
                  3393,
                  3397
                ],
                "dict"
              ]
            }
          ]
        }
      }
    },
    {
      "Def": {
        "header": {
          "Fun": [
            {
              "Fun": [
                {
                  "Var": "comparable"
                },
                {
                  "Var": "comparable2"
                }
              ]
            },
            {
              "Fun": [
                {
                  "Tag": [
                    "Set",
                    [
                      {
                        "Var": "comparable"
                      }
                    ]
                  ]
                },
                {
                  "Tag": [
                    "Set",
                    [
                      {
                        "Var": "comparable2"
                      }
                    ]
                  ]
                }
              ]
            }
          ]
        },
        "name": "map",
        "patterns": [
          {
            "Var": "func"
          },
          {
            "Var": "set"
          }
        ],
        "expr": {
          "Application": [
            [
              3561,
              3608
            ],
            {
              "Ref": [
                [
                  3561,
                  3569
                ],
                "fromList"
              ]
            },
            {
              "Application": [
                [
                  3571,
                  3607
                ],
                {
                  "Application": [
                    [
                      3571,
                      3607
                    ],
                    {
                      "Application": [
                        [
                          3571,
                          3607
                        ],
                        {
                          "Ref": [
                            [
                              3571,
                              3576
                            ],
                            "foldl"
                          ]
                        },
                        {
                          "Lambda": [
                            [
                              3578,
                              3599
                            ],
                            [
                              {
                                "Var": "x"
                              },
                              {
                                "Var": "xs"
                              }
                            ],
                            {
                              "OpChain": [
                                [
                                  3587,
                                  3599
                                ],
                                [
                                  {
                                    "Application": [
                                      [
                                        3587,
                                        3593
                                      ],
                                      {
                                        "Ref": [
                                          [
                                            3587,
                                            3591
                                          ],
                                          "func"
                                        ]
                                      },
                                      {
                                        "Ref": [
                                          [
                                            3592,
                                            3593
                                          ],
                                          "x"
                                        ]
                                      }
                                    ]
                                  },
                                  {
                                    "Ref": [
                                      [
                                        3597,
                                        3599
                                      ],
                                      "xs"
                                    ]
                                  }
                                ],
                                [
                                  "::"
                                ]
                              ]
                            }
                          ]
                        }
                      ]
                    },
                    {
                      "List": [
                        [
                          3601,
                          3604
                        ],
                        []
                      ]
                    }
                  ]
                },
                {
                  "Ref": [
                    [
                      3604,
                      3607
                    ],
                    "set"
                  ]
                }
              ]
            }
          ]
        }
      }
    },
    {
      "Def": {
        "header": {
          "Fun": [
            {
              "Fun": [
                {
                  "Var": "comparable"
                },
                {
                  "Tag": [
                    "Bool",
                    []
                  ]
                }
              ]
            },
            {
              "Fun": [
                {
                  "Tag": [
                    "Set",
                    [
                      {
                        "Var": "comparable"
                      }
                    ]
                  ]
                },
                {
                  "Tag": [
                    "Set",
                    [
                      {
                        "Var": "comparable"
                      }
                    ]
                  ]
                }
              ]
            }
          ]
        },
        "name": "filter",
        "patterns": [
          {
            "Var": "isGood"
          },
          {
            "Adt": [
              "Set_elm_builtin",
              [
                {
                  "Var": "dict"
                }
              ]
            ]
          }
        ],
        "expr": {
          "Application": [
            [
              3991,
              4048
            ],
            {
              "Ref": [
                [
                  3991,
                  4007
                ],
                "Set_elm_builtin"
              ]
            },
            {
              "Application": [
                [
                  4008,
                  4047
                ],
                {
                  "Application": [
                    [
                      4008,
                      4047
                    ],
                    {
                      "QualifiedRef": [
                        [
                          4008,
                          4020
                        ],
                        [
                          "Dict"
                        ],
                        "filter"
                      ]
                    },
                    {
                      "Lambda": [
                        [
                          4021,
                          4041
                        ],
                        [
                          {
                            "Var": "key"
                          },
                          "Wildcard"
                        ],
                        {
                          "Application": [
                            [
                              4031,
                              4041
                            ],
                            {
                              "Ref": [
                                [
                                  4031,
                                  4037
                                ],
                                "isGood"
                              ]
                            },
                            {
                              "Ref": [
                                [
                                  4038,
                                  4041
                                ],
                                "key"
                              ]
                            }
                          ]
                        }
                      ]
                    }
                  ]
                },
                {
                  "Ref": [
                    [
                      4043,
                      4047
                    ],
                    "dict"
                  ]
                }
              ]
            }
          ]
        }
      }
    },
    {
      "Def": {
        "header": {
          "Fun": [
            {
              "Fun": [
                {
                  "Var": "comparable"
                },
                {
                  "Tag": [
                    "Bool",
                    []
                  ]
                }
              ]
            },
            {
              "Fun": [
                {
                  "Tag": [
                    "Set",
                    [
                      {
                        "Var": "comparable"
                      }
                    ]
                  ]
                },
                {
                  "Tuple": [
                    {
                      "Tag": [
                        "Set",
                        [
                          {
                            "Var": "comparable"
                          }
                        ]
                      ]
                    },
                    {
                      "Tag": [
                        "Set",
                        [
                          {
                            "Var": "comparable"
                          }
                        ]
                      ]
                    }
                  ]
                }
              ]
            }
          ]
        },
        "name": "partition",
        "patterns": [
          {
            "Var": "isGood"
          },
          {
            "Adt": [
              "Set_elm_builtin",
              [
                {
                  "Var": "dict"
                }
              ]
            ]
          }
        ],
        "expr": {
          "Let": [
            [
              4329,
              4458
            ],
            [
              {
                "Pattern": [
                  {
                    "Tuple": [
                      {
                        "Var": "dict1"
                      },
                      {
                        "Var": "dict2"
                      }
                    ]
                  },
                  {
                    "Application": [
                      [
                        4360,
                        4402
                      ],
                      {
                        "Application": [
                          [
                            4360,
                            4402
                          ],
                          {
                            "QualifiedRef": [
                              [
                                4360,
                                4375
                              ],
                              [
                                "Dict"
                              ],
                              "partition"
                            ]
                          },
                          {
                            "Lambda": [
                              [
                                4376,
                                4396
                              ],
                              [
                                {
                                  "Var": "key"
                                },
                                "Wildcard"
                              ],
                              {
                                "Application": [
                                  [
                                    4386,
                                    4396
                                  ],
                                  {
                                    "Ref": [
                                      [
                                        4386,
                                        4392
                                      ],
                                      "isGood"
                                    ]
                                  },
                                  {
                                    "Ref": [
                                      [
                                        4393,
                                        4396
                                      ],
                                      "key"
                                    ]
                                  }
                                ]
                              }
                            ]
                          }
                        ]
                      },
                      {
                        "Ref": [
                          [
                            4398,
                            4402
                          ],
                          "dict"
                        ]
                      }
                    ]
                  }
                ]
              }
            ],
            {
              "Tuple": [
                [
                  4412,
                  4458
                ],
                [
                  {
                    "Application": [
                      [
                        4413,
                        4434
                      ],
                      {
                        "Ref": [
                          [
                            4413,
                            4429
                          ],
                          "Set_elm_builtin"
                        ]
                      },
                      {
                        "Ref": [
                          [
                            4429,
                            4434
                          ],
                          "dict1"
                        ]
                      }
                    ]
                  },
                  {
                    "Application": [
                      [
                        4436,
                        4457
                      ],
                      {
                        "Ref": [
                          [
                            4436,
                            4452
                          ],
                          "Set_elm_builtin"
                        ]
                      },
                      {
                        "Ref": [
                          [
                            4452,
                            4457
                          ],
                          "dict2"
                        ]
                      }
                    ]
                  }
                ]
              ]
            }
          ]
        }
      }
    }
  ]
}