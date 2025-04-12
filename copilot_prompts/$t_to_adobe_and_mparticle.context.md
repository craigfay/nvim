## Context

Upstream, a frontend web app is calling the function `window.$t` to emit events, like this:

```js
let myEventData = { myKey: 5, myOtherKey: 'click' };
$t('track', 'myeventname', myEventData);
```

Our repo adds event listeners to handle these events, like this:

```js
$t('on', 'myeventname', function (eventType, myEventData) {
  // ...
});
```

Often, these callbacks are using the JavaScript SDKs of 3rd party analytics
platforms like Adobe AppMeasurement or mParticle, and calling functions that
abstract away the details of making network requests that post the event data
to a database.

Here's a real example for Adobe AppMeasurement:

```js
// Defining a helper function to hide multiple steps
// involved in sending events to Adobe.
function track(situation, actionContextData) {
  // Merging the existing context data with the incoming context data
  s.contextData = s.extendArray(s.contextData, actionContextData);
  
  // The first two arguments are practically always the same.
  // The `situation` argument is essentially an "event name".
  s.tl(true, 'o', situation);

  // Cleaning up the incoming data, so the state isn't polluted
  // for the next caller of `window.s.tl`
  for (var item in actionContextData) {
    delete s.contextData[item];
  }
}

// Subscribing the the relevant $t event
$t('on', 'mbt_bacon_click', function (e, data = {}) {

  // Using a property of the event data to determine its type.
  // every event type has different data, although they follow a loose
  // set of design patterns - typically including an `action` property.
  if (data.action === 'addToCart') {
    let lmt = `Add Item To Cart ${data.item.seller ? data.item.seller: ''}`;
    
    // Almost always, the `actionContextData` contains these two keys:
    // `news.linkmoduledetail`, and `news.linkmoduletype`. They are special
    // keys that the downstream service looks for. They represent two levels
    // of granularity or specificty about the event. Note the first argument
    // to the `track` function, called `situation` acts as the highest level
    // of courseness, so there are effectively 3 dimensions of variation for
    // an event. `news.linkmoduletype` is the 2nd most granular, and
    // `news.linkmoduledetail` is the most granular.
    //
    // Note that `situation` is also known as "pev2", because that is the way
    // that it appears in network requests to Adobe.
    //
    // Often, the incoming $t event data object has more than 3 interesting
    // pieces of data that are worth reporting, so it's often necessary to
    // concatenate data so that it fits into the available space.
    track('bacon module click', {
      'news.linkmoduledetail': stringifyProduct(data.item),
      'news.linkmoduletype': lmt,
    });
  }

  else if (data.action === 'addAllItemsToCart') {
    // Getting the first item
    let [item] = data.items;

    // The `situation` argument is usually a more human-friendly interpretation
    // of either the $t event name (in this case, "mbt_bacon_click"), or `data.actiion`.
    track('bacon module click', {
      // When we have a list that needs to be packed into one property,
      // we usually comma or semicolon separate the items, depending on which
      // characters are less likely to be contained in the list's values.
      'news.linkmoduledetail': data.items.map(stringifyProduct).join(';'),
      'news.linkmoduletype': `Add All Items To Cart ${item.seller ? item.seller : ''}`,
    });
  }
});

```
