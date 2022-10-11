# Instructions

Source data: https://github.com/evasive-software/csp-q2-2022/tree/master/mobile

The file `data/input-data.json` contains a list of records representing stock transformations of pieces of timber in the distribution centre.

The data set only represents a single transformation type; timber docking.

Timber docking is the process of taking one or more source pieces of timber of a certain length, and cutting them down into smaller child pieces.

For example, a piece of timber 12 metres long could be cut in half to make two pieces that are 6 metres each. Another example could be cutting two 9 metre lengths into thirds to make six pieces at 3 metres.

The first example would be represented in the data set as per below

```json
{
	"transaction": "[transaction number]",
	"transformations": [
		{
			"partNum": "SL1524042H2S",
			"qty": -1,
			"size": 12
		},
		{
			"partNum": "SL1524042H2S",
			"qty": 2,
			"size": 6
		}
	]
}
```

which yields a balance of 0, since (-1 * 12 = -12) + (2 * 6 = 12) = 0

and the second example would be presented in the data set as per below

```json
{
	"transaction": "[transaction number]",
	"transformations": [
		{
			"partNum": "SL1524042H2S",
			"qty": -2,
			"size": 9
		},
		{
			"partNum": "SL1524042H2S",
			"qty": 6,
			"size": 3
		}
	]
}
```
which also yields a balance of 0

Observe that the source parts are represented by a negative quantity (as they are being consumed) and the child parts are represented as a positive quantity (as they are being produced).

Valid timber docking transactions will never have:

- A source `partNum` that does not match the child `partNum`s
- Child parts shorter than 3 metres or longer than 12 metres
- Child parts that are not in increments of 0.3 metres within this range (i.e. 3, 3.3, 3.6, ... 11.7, 12)

## Part 1

After forking this repository to your own GitHub account, write a TypeScript program that performs the following

1. Reads the data from `data/input-data.json`

2. Calculates the balance for each transaction in the data

3. Determines whether or not the transaction is valid based upon the constraints outlined previously (or any other physical scenarios you can think of)

4. Writes a modified data set to `data/output-data.json` which contains a `balance`, `isValid`, and `reason` field (along side the original data).

For example, the modified entry from the first example set might look like

```json
{
	"transaction": "[transaction number]",
	"transformations": [
		{
			"partNum": "SL1524042H2S",
			"qty": -1,
			"size": 12
		},
		{
			"partNum": "SL1524042H2S",
			"qty": 2,
			"size": 6
		}
	],
	"balance": 0,
	"isValid": true,
	"errorReason": null
}
```


## Part 2

After you're happy with your solution, create a small react-native application so

- Users can press a button to open a file (`input-data.json`) from their device and press a "process" button
- Pressing the process utilises your previous program to compute the balance, validity and error reasons for each transaction.
- A table of information is presented to the user displaying the number of valid transactions, invalid transactions, and the sum of all balances in the opened data set.

You should use react-native with TypeScript. You can use third party libraries if you wish, but there is no expectation that you need to configure routing or state management. A single screen is sufficient. You don't need to build and run on a real device - an emulator is sufficient.


## Submitting your solution

After testing your code, commit your changes as well as your `data/output-data.json` file and push it back into your repository. Be sure to email through a link to your GitHub repository so it can be checked.