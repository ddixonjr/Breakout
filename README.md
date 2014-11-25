<html>
<body>
<h1>Breakout Reference</h1>
<p>Breakout is a simple demo/portfolio app that implements a basic version of the classic arcade game Breakout.  I coded it in response to a code challenge. I had a bit more time than with other challenges so I really tried to step on the gas with protocols and the delegation design patterns as well as the facade design pattern to create a clean separation of view/view controller responsibilties from those of the game logic and model objects.</p>
<p>Primary Frameworks, Classes, and Protocols Utilized:</p>
<ul>
<li>Foundation (NSArray, NSDictionary)</li>
<li>UIKit (UIViewController, UINavigationController, UIControl, UIView subclasses and animations, etc.)</li>
<li>UIKit Dynamics (UIDynamicsAnimator, UICollisionBehavior, UIPushBehavior, UIDynamicItemBehavior)</li>
</ul>
</p>
<p>Primary Design Patterns, Coding Techniques, and iOS Capabilities Utilized:<br>
<ul>
<li>MVC</li>
<li>Target-Action</li>
<li>ResponderChain/Chain of Responsibility</li>
<li>Facade</li>
<li>Composite</li>
<li>Delegation & Obj-C Protocols</li>
</ul>
</p>
<p>The class reference documentation below describes those responsibilities along with the APIs that facilitate interaction between the classes that make up the app.</p>
<p><br></p>
<h3>Class References</h3>
<ul class="ul1">
  <li class="li3">BRKOBreakoutGame</li>
  <li class="li3">BRKOBlockGrid</li>
  <li class="li3">BRKOBlock</li>
  <li class="li3">BRKOBlockDescriptor</li>
  <li class="li3">BRKOPlayer</li>
  <li class="li3">BRKOPlayersManager</li>
  <li class="li3">BRKOPlayersViewController</li>
  <li class="li3">BRKOBreakoutGameViewController</li>
  <li class="li3">BRKOBallView</li>
  <li class="li3">BRKOPaddleView</li>
  <li class="li3">BRKOBlockView</li>
</ul>
<h3>Protocol References</h3>
<ul class="ul1">
  <li class="li3">BRKOBreakoutGameDelegate</li>
</ul>
<p class="p5"><br></p>
<p class="p5"><br></p>
<p class="p6"><br></p>
<h2>BRKOBreakoutGame Class Reference</h2>
<table cellspacing="0" cellpadding="0" class="t1">
  <tbody>
    <tr>
      <td valign="top" class="td1">
        <p class="p7"><b>Inherits from</b></p>
      </td>
      <td valign="top" class="td2">
        <p class="p7">NSObject</p>
      </td>
    </tr>
    <tr>
      <td valign="top" class="td1">
        <p class="p7"><b>Declared in</b></p>
      </td>
      <td valign="top" class="td2">
        <p class="p7">BRKOBreakoutGame.h</p>
        <p class="p7">BRKOBreakoutGame.m</p>
      </td>
    </tr>
  </tbody>
</table>
<p class="p8"><br></p>
<h3>Overview</h3>
<p class="p10">A facade class implementing an entire model of a game of Breakout. Breakout is a game where a player is given a paddle at the bottom end of a screen, a set of blocks at the top end of a screen, and a moving ball that (when kept bouncing in the area of play) hits and destroys the blocks. The object is to continue hitting and destroying blocks to increase score and continue clearing “boards” of blocks. This class uses a BKROPlayersManager instance, and manages BKROBlockGrid, <span class="s1">BRKOBlock</span>, BKROBlockDescriptor, and <span class="s1">BRKOPlayer</span> objects to implement entire games of breakout between one or more playing users.</p>
<h3>Tasks</h3>
<ul class="ul1">
  <li class="li11">  delegate<span class="s2"> </span><span class="s3">property</span></li>
  <li class="li11">  playersManager<span class="s2"> </span><span class="s3">property</span></li>
  <li class="li11">– startGame:</li>
  <li class="li11">– stopGame</li>
  <li class="li11">– restartGame:</li>
  <li class="li11">– turnEnded</li>
  <li class="li11">– destroyHitBlockWithBlockDescriptor:</li>
  <li class="li11">– turnsLeftForCurrentPlayer</li>
</ul>
<h3>Properties</h3>
<b>delegate</b>
<p class="p14">A reference to an object conforming to the <span class="s1">BRKOBreakoutGameDelegate</span> protocol in order to be informed of changes to the game model. This will typically be a view controller responsible for the view hierarchy presenting the game board to the user.</p>
<p class="p15">@property (strong, nonatomic) id&lt;BRKOBreakoutGameDelegate&gt; delegate</p>
<p class="p16"><br></p>
<p>Discussion</p>
<p class="p14">An object conforming to the <span class="s1">BRKOBreakoutGameDelegate</span> protocol in order to be informed of changes to the game model. This will typically be a view controller responsible for the view hierarchy presenting the game board to the user.</p>
<p>Declared In</p>
<p class="p18">BRKOBreakoutGame.h</p>
<p class="p16"><br></p>
<b>playersManager</b>
<p class="p14">An instance of <span class="s1">BRKOPlayersManager</span> that provides an interface for managing the <span class="s1">players</span> in the current game.</p>
<p class="p15">@property (weak, nonatomic) BRKOPlayersManager *playersManager</p>
<p class="p16"><br></p>
<p>Discussion</p>
<p class="p14">An instance of <span class="s1">BRKOPlayersManager</span> that provides an interface for managing the <span class="s1">players</span> in the current game.</p>
<p>Declared In</p>
<p class="p18">BRKOBreakoutGame.h</p>
<p class="p16"><br></p>
<h3>Instance Methods</h3>
<b>destroyHitBlockWithBlockDescriptor:</p>
<p class="p14">Allows the presenting view controller to indicate when a block has been hit by the ball in the view representing the game board to the user. breakoutGame:playerName:hasTurnsLeft:withClearBoardStatus:andCurrentScore:, breakoutGame:startNewPlayerNamed:withTurnsLeft:fromPreviousPlayer:, or breakoutGame:gameOverWithWinner:andScore: method based on whether the player still has remaining turns, those turns have expired, or the game is over, respectively.</p>
<p class="p15">- (BOOL)destroyHitBlockWithBlockDescriptor:(BRKOBlockDescriptor *)<i>BlockDescriptor</i></p>
<p class="p16"><br></p>
<p class="p17"><b>Parameters</b></p>
<p class="p20">BlockDescriptor</p>
<p class="p14">A <span class="s1">BRKOBlockDescriptor</span> object describing the exact block in the block grid that has been hit by the ball.</p>
<p class="p17"><b>Return Value</b></p>
<p class="p14">An indicator of whether or not the hit has destroyed the block instance (<span class="s1">BRKOBlock</span>) in the model of the block grid (<span class="s1">BRKOBlockGrid</span>).</p>
<p>Discussion</p>
<p class="p14">Allows the presenting view controller to indicate when a block has been hit by the ball in the view representing the game board to the user. breakoutGame:playerName:hasTurnsLeft:withClearBoardStatus:andCurrentScore:, breakoutGame:startNewPlayerNamed:withTurnsLeft:fromPreviousPlayer:, or breakoutGame:gameOverWithWinner:andScore: method based on whether the player still has remaining turns, those turns have expired, or the game is over, respectively.</p>
<p>Declared In</p>
<p class="p18">BRKOBreakoutGame.h</p>
<p class="p16"><br></p>
<b>restartGame:</b>
<p class="p14">A convenience method to release the current block grid and trigger either the start of a new game or of a new set of turns for the next player.</p>
<p class="p15">- (void)restartGame:(BOOL)<i>isNewGame</i></p>
<p class="p19"><b></b><br></p>
<p class="p17"><b>Parameters</b></p>
<p class="p20">isNewGame</p>
<p class="p14">The flag to trigger either the start of a new game or of a new set of turns for the next player.</p>
<p>Discussion</p>
<p class="p14">A convenience method to release the current block grid and trigger either the start of a new game or of a new set of turns for the next player.</p>
<p>Declared In</p>
<p class="p18">BRKOBreakoutGame.h</p>
<p class="p21"><br></p>
<b>startGame:</b>
<p class="p14">A method that initializes a new game. This consists of the following. 1. Instantiating a <span class="s1">BRKOBlockGrid</span> object. 2. Creating an array of <span class="s1">BRKOBlockDescriptor</span> objects representing the <span class="s1">BRKOBlock</span> objects for each row of blocks in the <span class="s1">BRKOBlockGrid</span> object. (This facilitates a way to relay block data abstractly to decouple the presenting view controller from the details of the <span class="s1">BRKOBlock</span> class interface. The goal being to minimize the classes to which the presenting view controller has to be coupled.) 3. Calls the breakoutGame:blockGridRow:hasBlocksWithBlockDescriptors: <span class="s1">delegate</span> method to relay the block row information to the presenting view controller. 4. When completed, the initial breakoutGame:playerName:hasTurnsLeft:withClearBoardStatus:andCurrentScore: <span class="s1">delegate</span> method call is invoked to start the set of turns for the current player.</p>
<p class="p15">- (void)startGame:(BOOL)<i>isNewGame</i></p>
<p class="p19"><b></b><br></p>
<p class="p17"><b>Parameters</b></p>
<p class="p20">isNewGame</p>
<p class="p14">An indication of whether this a completely new game or just the start of a set of turns for another player.</p>
<p>Discussion</p>
<p class="p14">A method that initializes a new game. This consists of the following.<span class="Apple-converted-space"> </span></p>
<p class="p14">1. Instantiating a <span class="s1">BRKOBlockGrid</span> object.<span class="Apple-converted-space"> </span></p>
<p class="p14">2. Creating an array of <span class="s1">BRKOBlockDescriptor</span> objects representing the <span class="s1">BRKOBlock</span> objects for each row of blocks in the <span class="s1">BRKOBlockGrid</span> object. (This facilitates a way to relay block data abstractly to decouple the presenting view controller from the details of the <span class="s1">BRKOBlock</span> class interface. The goal being to minimize the classes to which the presenting view controller has to be coupled.)<span class="Apple-converted-space"> </span></p>
<p class="p14">3. Calls the breakoutGame:blockGridRow:hasBlocksWithBlockDescriptors: <span class="s1">delegate</span> method to relay the block row information to the presenting view controller.<span class="Apple-converted-space"> </span></p>
<p class="p14">4. When completed, the initial breakoutGame:playerName:hasTurnsLeft:withClearBoardStatus:andCurrentScore: <span class="s1">delegate</span> method call is invoked to start the set of turns for the current player.</p>
<p>Declared In</p>
<p class="p18">BRKOBreakoutGame.h</p>
<p class="p21"><br></p>
<b>stopGame</b>
<p class="p14">A method that stops the game by releasing references to objects representing the current game: the current instances of <span class="s1">BRKOBlockGrid</span>, <span class="s1">BRKOPlayersManager</span>, and a local property referencing the array of <span class="s1">players</span> within the <span class="s1">BRKOPlayersManager</span> object.</p>
<p class="p15">- (void)stopGame</p>
<p class="p19"><b></b><br></p>
<p>Discussion</p>
<p class="p14">A method that stops the game by releasing references to objects representing the current game: the current instances of <span class="s1">BRKOBlockGrid</span>, <span class="s1">BRKOPlayersManager</span>, and a local property referencing the array of <span class="s1">players</span> within the <span class="s1">BRKOPlayersManager</span> object.</p>
<p>Declared In</p>
<p class="p18">BRKOBreakoutGame.h</p>
<p class="p21"><br></p>
<b>turnEnded</b>
<p class="p14">Allows the presenting view controller to indicate when a player has missed the ball and (as a result) lost their turn. This triggers a corresponding call to either the breakoutGame:playerName:hasTurnsLeft:withClearBoardStatus:andCurrentScore:, breakoutGame:startNewPlayerNamed:withTurnsLeft:fromPreviousPlayer:, or breakoutGame:gameOverWithWinner:andScore: method based on whether the player still has remaining turns, those turns have expired, or the game is over, respectively.</p>
<p class="p15">- (void)turnEnded</p>
<p class="p19"><b></b><br></p>
<p>Discussion</p>
<p class="p14">Allows the presenting view controller to indicate when a player has missed the ball and (as a result) lost their turn. This triggers a corresponding call to either the breakoutGame:playerName:hasTurnsLeft:withClearBoardStatus:andCurrentScore:, breakoutGame:startNewPlayerNamed:withTurnsLeft:fromPreviousPlayer:, or breakoutGame:gameOverWithWinner:andScore: method based on whether the player still has remaining turns, those turns have expired, or the game is over, respectively.</p>
<p>Declared In</p>
<p class="p18">BRKOBreakoutGame.h</p>
<p class="p16"><br></p>
<b>turnsLeftForCurrentPlayer</b>
<p class="p14">Determines the number of turns left for the current player.</p>
<p class="p15">- (NSInteger)turnsLeftForCurrentPlayer</p>
<p class="p17"><b>Return Value</b></p>
<p class="p14">The number of turns left for the current player.</p>
<p>Discussion</p>
<p class="p14">Determines the number of turns left for the current player.</p>
<p>Declared In</p>
<p class="p18">BRKOBreakoutGame.h</p>
<p class="p22"><br></p>
<p class="p23">© 2014 Appivot. All rights reserved. (Last updated: 2014-11-24)<span class="s4"><br>
</span><span class="s5">Generated by </span><span class="s6">appledoc 2.2 (build 963)</span><span class="s5">.</span></p>
<p class="p24"><br></p>
<h2>BRKOBreakoutGameDelegate Protocol Reference</h2>
<table cellspacing="0" cellpadding="0" class="t1">
  <tbody>
    <tr>
      <td valign="top" class="td3">
        <p class="p7"><b>Conforms to</b></p>
      </td>
      <td valign="top" class="td4">
        <p class="p7">NSObject</p>
      </td>
    </tr>
    <tr>
      <td valign="top" class="td3">
        <p class="p7"><b>Declared in</b></p>
      </td>
      <td valign="top" class="td4">
        <p class="p7">BRKOBreakoutGame.h</p>
      </td>
    </tr>
  </tbody>
</table>
<p class="p8"><br></p>
<h3>Overview</h3>
<p class="p10">Conformance to this protocol facilitates feedback from a <span class="s1">BRKOBreakoutGame</span> game model object to a view controller providing presentation logic of the game to the user.</p>
<h3>Tasks</h3>
<ul class="ul1">
  <li class="li11">– breakoutGame:blockGridHasNumberOfRows:<span class="s2"> </span><span class="s3">required method</span></li>
  <li class="li11">– breakoutGame:blockGridRow:hasBlocksWithBlockDescriptors:<span class="s2"> </span><span class="s3">required method</span></li>
  <li class="li11">– breakoutGame:playerName:hasTurnsLeft:withClearBoardStatus:andCurrentScore:<span class="s2"> </span><span class="s3">required method</span></li>
  <li class="li11">– breakoutGame:startNewPlayerNamed:withTurnsLeft:fromPreviousPlayer:<span class="s2"> </span><span class="s3">required method</span></li>
  <li class="li11">– breakoutGame:gameOverWithWinner:andScore:<span class="s2"> </span><span class="s3">required method</span></li>
</ul>
<p class="p8"><br></p>
<h3>Instance Methods</h3>
<b>breakoutGame:blockGridHasNumberOfRows:</b>
<p class="p14">Provides the number of rows of blocks modeled by the <span class="s1">BRKOBreakoutGame</span> game model instance.</p>
<p class="p15">- (void)breakoutGame:(BRKOBreakoutGame *)<i>breakoutGame</i> blockGridHasNumberOfRows:(NSInteger)<i>rows</i></p>
<p class="p19"><b></b><br></p>
<p class="p17"><b>Parameters</b></p>
<p class="p16"><br></p>
<p class="p20">breakoutGame</p>
<p class="p14">The <span class="s1">BRKOBreakoutGame</span> instance that invoked the delegate method call.</p>
<p class="p20">rows</p>
<p class="p14">The number of rows being modeled.</p>
<p>Discussion</p>
<p class="p14">Provides the number of rows of blocks modeled by the <span class="s1">BRKOBreakoutGame</span> game model instance.</p>
<p>Declared In</p>
<p class="p18">BRKOBreakoutGame.h</p>
<p class="p21"><br></p>
<b>breakoutGame:blockGridRow:hasBlocksWithBlockDescriptors:</b>
<p class="p14">Provides an array of BRKOBlockDescriptor objects belonging to the specified row.</p>
<p class="p15">- (void)breakoutGame:(BRKOBreakoutGame *)<i>breakoutGame</i> blockGridRow:(NSInteger)<i>row</i> hasBlocksWithBlockDescriptors:(NSArray *)<i>blockRowDescriptorArray</i></p>
<p class="p19"><b></b><br></p>
<p class="p17"><b>Parameters</b></p>
<p class="p16"><br></p>
<p class="p20">breakoutGame</p>
<p class="p14">The <span class="s1">BRKOBreakoutGame</span> instance that invoked the delegate method call.</p>
<p class="p20">row</p>
<p class="p14">The row number this group of BRKOBlockDescriptor objects belongs to.</p>
<p class="p20">blockRowDescriptorArray</p>
<p class="p14">An array of BRKOBlockDescriptor objects belonging to the specified row.</p>
<p>Discussion</p>
<p class="p14">Provides an array of BRKOBlockDescriptor objects belonging to the specified row.</p>
<p>Declared In</p>
<p class="p18">BRKOBreakoutGame.h</p>
<p class="p21"><br></p>
<b>breakoutGame:gameOverWithWinner:andScore:</b>
<p class="p14">This delegate method is called to inform the presenting view controller when the current game has ended (i.e. when all players have expired all of their turns).</p>
<p class="p15">- (void)breakoutGame:(BRKOBreakoutGame *)<i>breakoutGame</i> gameOverWithWinner:(NSString *)<i>player</i> andScore:(NSInteger)<i>winningScore</i></p>
<p class="p19"><b></b><br></p>
<p class="p17"><b>Parameters</b></p>
<p class="p16"><br></p>
<p class="p20">breakoutGame</p>
<p class="p14">The <a href="file:///Users/Dennis/Library/Developer/Shared/Documentation/DocSets/com.appivot.breakout.Breakout.docset/Contents/Resources/Documents/Classes/BRKOBreakoutGame.html"><span class="s1">BRKOBreakoutGame</span></a> instance that invoked the delegate method call.</p>
<p class="p20">player</p>
<p class="p14">The name of the player that had the highest score.</p>
<p class="p20">winningScore</p>
<p class="p14">The score of the specified winning player.</p>
<p>Discussion</p>
<p class="p14">This delegate method is called to inform the presenting view controller when the current game has ended (i.e. when all players have expired all of their turns).</p>
<p>Declared In</p>
<p class="p18">BRKOBreakoutGame.h</p>
<p class="p21"><br></p>
<b>breakoutGame:playerName:hasTurnsLeft:withClearBoardStatus:andCurrentScore:</b>
<p class="p14">This delegate method call is made in response to every invocation of destroyHitBlockWithBlockDescriptor: by the presenting view controller to provide a real-time status update on the current player’s turns remaining, score, and whether or not the board has been cleared.</p>
<p class="p15">- (void)breakoutGame:(BRKOBreakoutGame *)<i>breakoutGame</i> playerName:(NSString *)<i>player</i> hasTurnsLeft:(NSInteger)<i>turnsLeft</i> withClearBoardStatus:(BOOL)<i>isBoardCleared</i> andCurrentScore:(NSInteger)<i>score</i></p>
<p class="p19"><b></b><br></p>
<p class="p17"><b>Parameters</b></p>
<p class="p16"><br></p>
<p class="p20">breakoutGame</p>
<p class="p14">The <span class="s1">BRKOBreakoutGame</span> instance that invoked the delegate method call.</p>
<p class="p20">player</p>
<p class="p14">The name of the player this update is associated with this information.</p>
<p class="p20">turnsLeft</p>
<p class="p14">The number of turns left for the specified player.</p>
<p class="p20">isBoardCleared</p>
<p class="p14">An indicator of whether or not the board has been cleared.</p>
<p class="p20">score</p>
<p class="p14">The current score for the specified player.</p>
<p>Discussion</p>
<p class="p14">This delegate method call is made in response to every invocation of destroyHitBlockWithBlockDescriptor: by the presenting view controller to provide a real-time status update on the current player’s turns remaining, score, and whether or not the board has been cleared.</p>
<p>Declared In</p>
<p class="p18">BRKOBreakoutGame.h</p>
<p class="p21"><br></p>
<b>breakoutGame:startNewPlayerNamed:withTurnsLeft:fromPreviousPlayer:</b>
<p class="p14">This delegate method call is made in response to an invokation of turnEnded: by the presenting view controller when the current player has been determined to be out of turns. This allows the <a href="file:///Users/Dennis/Library/Developer/Shared/Documentation/DocSets/com.appivot.breakout.Breakout.docset/Contents/Resources/Documents/Classes/BRKOBreakoutGame.html"><span class="s1">BRKOBreakoutGame</span></a> game object to provide the view controller with information on the next player needed to start that players set of turns.</p>
<p class="p15">- (void)breakoutGame:(BRKOBreakoutGame *)<i>breakoutGame</i> startNewPlayerNamed:(NSString *)<i>player</i> withTurnsLeft:(NSInteger)<i>turnsLeft</i> fromPreviousPlayer:(NSString *)<i>previousPlayer</i></p>
<p class="p19"><b></b><br></p>
<p class="p17"><b>Parameters</b></p>
<p class="p16"><br></p>
<p class="p20">breakoutGame</p>
<p class="p14">The <a href="file:///Users/Dennis/Library/Developer/Shared/Documentation/DocSets/com.appivot.breakout.Breakout.docset/Contents/Resources/Documents/Classes/BRKOBreakoutGame.html"><span class="s1">BRKOBreakoutGame</span></a> instance that invoked the delegate method call.</p>
<p class="p20">player</p>
<p class="p14">The name of the player that has become the current player.</p>
<p class="p20">turnsLeft</p>
<p class="p14">The number of turns for the specified player.</p>
<p class="p20">previousPlayer</p>
<p class="p14">The name of the player that has become the previous player.</p>
<p>Discussion</p>
<p class="p14">This delegate method call is made in response to an invocation of turnEnded: by the presenting view controller when the current player has been determined to be out of turns. This allows the <span class="s1">BRKOBreakoutGame</span> game object to provide the view controller with information on the next player needed to start that players set of turns.</p>
<p>Declared In</p>
<p class="p18">BRKOBreakoutGame.h</p>
<p class="p22"><br></p>
<p class="p23">© 2014 Appivot. All rights reserved. (Last updated: 2014-11-24)<span class="s4"><br>
</span><span class="s5">Generated by </span><span class="s6">appledoc 2.2 (build 963)</span><span class="s5">.</span></p>
<p class="p6"><br></p>
<h2>BRKOBlockGrid Class Reference</h2>
<table cellspacing="0" cellpadding="0" class="t1">
  <tbody>
    <tr>
      <td valign="top" class="td1">
        <p class="p7"><b>Inherits from</b></p>
      </td>
      <td valign="top" class="td5">
        <p class="p7">NSObject</p>
        <p class="p25"><br></p>
      </td>
    </tr>
    <tr>
      <td valign="top" class="td1">
        <p class="p7"><b>Declared in</b></p>
      </td>
      <td valign="top" class="td5">
        <p class="p7">BRKOBlockGrid.h</p>
        <p class="p7">BRKOBlockGrid.m</p>
      </td>
    </tr>
  </tbody>
</table>
<p class="p8"><br></p>
<h3>Overview</h3>
<p class="p10">A model class that represents a grid of blocks for a round of Breakout. A block grid is a set of rows each of which contains a set of Breakout game blocks (<span class="s1">BRKOBlock</span> objects). This class facilitates management of and access to information about the blocks within the grid throughout one full round of Breakout.</p>
<h3>Tasks</h3>
<ul class="ul1">
  <li class="li11">  blockCountPerRowArray<span class="s2"> </span><span class="s3">property</span></li>
  <li class="li11">  blockRows<span class="s2"> </span><span class="s3">property</span></li>
  <li class="li11">– initRandomBlockGridWithDifficulty:</li>
  <li class="li11">– destroyBlockWithBlockDescriptor:</li>
  <li class="li11">– numberOfBlocksInRowWithBlockDescriptor:</li>
  <li class="li11">– blockStrengthOfBlockWithBlockDescriptor:</li>
  <li class="li11">– isBlockGridCleared</li>
</ul>
<p class="p8"><br></p>
<h3>Properties</h3>
<b>blockCountPerRowArray</b>
<p class="p14">An array containing the number of blocks in each row of the grid.</p>
<p class="p15">@property (strong, nonatomic) NSMutableArray *blockCountPerRowArray</p>
<p class="p19"><b></b><br></p>
<p>Discussion</p>
<p class="p14">An array containing the number of blocks in each row of the grid.</p>
<p>Declared In</p>
<p class="p18">BRKOBlockGrid.h</p>
<p class="p16"><br></p>
<b>blockRows</b>
<p class="p14">A convenience property to return the number rows in the block grid.</p>
<p class="p15">@property (assign, nonatomic) NSInteger blockRows</p>
<p class="p19"><b></b><br></p>
<p>Discussion</p>
<p class="p14">A convenience property to return the number rows in the block grid.</p>
<p>Declared In</p>
<p class="p18">BRKOBlockGrid.h</p>
<p class="p16"><br></p>
<h3>Instance Methods</h3>
<b>blockStrengthOfBlockWithBlockDescriptor:</b>
<p class="p14">Returns an integer representing the strength level of the block specified by the BRKOBlockDescriptor argument. Strength level is a value indicating the remaining staying power of the block. Currently, that is the number of hits to destroy the block but could be enhanced to be a more complex measure of strength.</p>
<p class="p15">- (NSInteger)blockStrengthOfBlockWithBlockDescriptor:(BRKOBlockDescriptor *)<i>BlockDescriptor</i></p>
<p class="p16"><br></p>
<p class="p17"><b>Parameters</b></p>
<b>BlockDescriptor</b>
<p class="p14">The BRKOBlockDescriptor indicating the block whose strength is being requested.</p>
<p class="p17"><b>Return Value</b></p>
<p class="p14">The strength level of the block specified by the BRKOBlockDescriptor argument.</p>
<p>Discussion</p>
<p class="p14">Returns an integer representing the strength level of the block specified by the BRKOBlockDescriptor argument. Strength level is a value indicating the remaining staying power of the block. Currently, that is the number of hits to destroy the block but could be enhanced to be a more complex measure of strength.</p>
<p>Declared In</p>
<p class="p18">BRKOBlockGrid.h</p>
<p class="p21"><br></p>
<b>destroyBlockWithBlockDescriptor:</b>
<p class="p14">A call indicating a hit/an attempt to destroy a block in the grid as indicated by the specified block descriptor.</p>
<p class="p15">- (NSInteger)destroyBlockWithBlockDescriptor:(BRKOBlockDescriptor *)<i>BlockDescriptor</i></p>
<p class="p17"><b>Parameters</b></p>
<p class="p20">BlockDescriptor</p>
<p class="p14">The block hit and possibly destroyed.</p>
<p class="p17"><b>Return Value</b></p>
<p class="p14">An integer representing the point value of the block if has been destroyed. A return value of zero indicates that the hit did not yet destroy the block.</p>
<p>Discussion</p>
<p class="p14">A call indicating a hit/an attempt to destroy a block in the grid as indicated by the specified block descriptor.</p>
<p>Declared In</p>
<p class="p18">BRKOBlockGrid.h</p>
<p class="p26"><br></p>
<p class="p16"><br></p>
<b>initRandomBlockGridWithDifficulty:</b>
<p class="p14">An initializer that instantiates a BRKOBlockGrid instance with a specified difficulty level where difficulty influences the number of blocks in each row and the number of hits required to destroy each block.</p>
<p class="p15">- (id)initRandomBlockGridWithDifficulty:(NSInteger)<i>difficulty</i></p>
<p class="p19"><b></b><br></p>
<p class="p17"><b>Parameters</b></p>
<p class="p20">difficulty</p>
<p class="p14">An integer influencing the overall difficulty of destroying the block grid.</p>
<p class="p17"><b>Return Value</b></p>
<p class="p14">A new instance of BRKOBlockGrid.</p>
<p>Discussion</p>
<p class="p14">An initializer that instantiates a BRKOBlockGrid instance with a specified difficulty level where difficulty influences the number of blocks in each row and the number of hits required to destroy each block.</p>
<p>Declared In</p>
<p class="p18">BRKOBlockGrid.h</p>
<p class="p21"><br></p>
<b>isBlockGridCleared</b>
<p class="p14">Allows the board clear status to be queried.</p>
<p class="p15">- (BOOL)isBlockGridCleared</p>
<p class="p17"><b>Return Value</b></p>
<p class="p14">An indicator of whether or not all the blocks in the board has been cleared.</p>
<p>Discussion</p>
<p class="p14">Allows the board clear status to be queried.</p>
<p>Declared In</p>
<p class="p18">BRKOBlockGrid.h</p>
<p class="p21"><br></p>
<b>numberOfBlocksInRowWithBlockDescriptor:</p>
<p class="p14">Returns the number of blocks in the same row as the block descriptor passed as an argument.</p>
<p class="p15">- (NSInteger)numberOfBlocksInRowWithBlockDescriptor:(BRKOBlockDescriptor *)<i>BlockDescriptor</i></p>
<p class="p17"><b>Parameters</b></p>
<p class="p20">BlockDescriptor</p>
<p class="p14">The BRKOBlockDescriptor instance carrying the row number for which the number of blocks is to be returned.</p>
<p class="p17"><b>Return Value</b></p>
<p class="p14">The number of blocks in the same row as the block descriptor passed as an argument.</p>
<p>Discussion</p>
<p class="p14">Returns the number of blocks in the same row as the block descriptor passed as an argument.</p>
<p>Declared In</p>
<p class="p18">BRKOBlockGrid.h</p>
<p class="p22"><br></p>
<p class="p23">© 2014 Appivot. All rights reserved. (Last updated: 2014-11-24)<span class="s4"><br>
</span><span class="s5">Generated by </span><span class="s6">appledoc 2.2 (build 963)</span><span class="s5">.</span></p>
<p class="p24"><br></p>
<p class="p24"><br></p>
<h2>BRKOBlock Class Reference</h2>
<table cellspacing="0" cellpadding="0" class="t1">
  <tbody>
    <tr>
      <td valign="top" class="td1">
        <p class="p7"><b>Inherits from</b></p>
      </td>
      <td valign="top" class="td3">
        <p class="p7">NSObject</p>
        <p class="p25"><br></p>
      </td>
    </tr>
    <tr>
      <td valign="top" class="td1">
        <p class="p7"><b>Declared in</b></p>
      </td>
      <td valign="top" class="td3">
        <p class="p7">BRKOBlock.h</p>
        <p class="p7">BRKOBlock.m</p>
      </td>
    </tr>
  </tbody>
</table>
<p class="p8"><br></p>
<h3>Overview</h3>
<p class="p10">A model class that represents a single block in a game of Breakout.</p>
<h3>Tasks</h3>
<ul class="ul1">
  <li class="li11">  hitsToDestroy<span class="s2"> </span><span class="s3">property</span></li>
  <li class="li11">  pointValue<span class="s2"> </span><span class="s3">property</span></li>
  <li class="li11">  hasBeenDestroyed<span class="s2"> </span><span class="s3">property</span></li>
  <li class="li11">– logHit</li>
</ul>
<p class="p8"><br></p>
<h3>Properties</h3>
<b>hasBeenDestroyed</b>
<p class="p14">A flag indicating whether or not a block instance has been destroyed.</p>
<p class="p15">@property (assign, readonly, nonatomic) BOOL hasBeenDestroyed</p>
<p class="p19"><b></b><br></p>
<p>Discussion</p>
<p class="p14">A flag indicating whether or not a block instance has been destroyed.</p>
<p>Declared In</p>
<p class="p18">BRKOBlock.h</p>
<p class="p21"><br></p>
<b>hitsToDestroy</b>
<p class="p14">The number of hits remaining for the block to be destroyed.</p>
<p class="p15">@property (assign, nonatomic) NSInteger hitsToDestroy</p>
<p class="p19"><b></b><br></p>
<p>Discussion</p>
<p class="p14">The number of hits remaining for the block to be destroyed.</p>
<p>Declared In</p>
<p class="p18">BRKOBlock.h</p>
<p class="p27"><br></p>
<b>pointValue</b>
<p class="p14">The number of points to be gained when the block has been destroyed.</p>
<p class="p15">@property (assign, readonly, nonatomic) NSInteger pointValue</p>
<p class="p19"><b></b><br></p>
<p>Discussion</p>
<p class="p14">The number of points to be gained when the block has been destroyed.</p>
<p>Declared In</p>
<p class="p18">BRKOBlock.h</p>
<p class="p16"><br></p>
<h3>Instance Methods</h3>
<b>logHit</b>
<p class="p14">A method call that tells the block instance it has been hit.</p>
<p class="p15">- (void)logHit</p>
<p class="p19"><b></b><br></p>
<p>Discussion</p>
<p class="p14">A method call that tells the block instance it has been hit.</p>
<p>Declared In</p>
<p class="p18">BRKOBlock.h</p>
<p class="p22"><br></p>
<p class="p23">© 2014 Appivot. All rights reserved. (Last updated: 2014-11-24)<span class="s4"><br>
</span><span class="s5">Generated by </span><span class="s6">appledoc 2.2 (build 963)</span><span class="s5">.</span></p>
<p class="p24"><br></p>
<p class="p24"><br></p>
<h2>BRKOBlockDescriptor Class Reference</h2>
<table cellspacing="0" cellpadding="0" class="t1">
  <tbody>
    <tr>
      <td valign="top" class="td1">
        <p class="p7"><b>Inherits from</b></p>
      </td>
      <td valign="top" class="td6">
        <p class="p7">NSObject</p>
        <p class="p25"><br></p>
      </td>
    </tr>
    <tr>
      <td valign="top" class="td1">
        <p class="p7"><b>Declared in</b></p>
      </td>
      <td valign="top" class="td6">
        <p class="p7">BRKOBlockDescriptor.h</p>
        <p class="p7">BRKOBlockDescriptor.m</p>
      </td>
    </tr>
  </tbody>
</table>
<p class="p8"><br></p>
<h3>Overview</h3>
<p class="p10">A class that generically encapsulates identification information about a specific block model object for associating view layer objects with corresponding model layer objects.</p>
<p class="p8"><br></p>
<h3>Tasks</h3>
<ul class="ul1">
  <li class="li11">  blockRow<span class="s2"> </span><span class="s3">property</span></li>
  <li class="li11">  blockPosition<span class="s2"> </span><span class="s3">property</span></li>
  <li class="li11">  blockStrength<span class="s2"> </span><span class="s3">property</span></li>
  <li class="li11">– initWithRow:andPosition:andStrength:</li>
</ul>
<p class="p8"><br></p>
<h3>Properties</h3>
<b>blockPosition</b>
<p class="p14">Property that identifies the corresponding block’s position within the row in the game model.</p>
<p class="p15">@property (assign, nonatomic) NSInteger blockPosition</p>
<p class="p19"><b></b><br></p>
<p>Discussion</p>
<p class="p14">Property that identifies the corresponding block’s position within the row in the game model.</p>
<p>Declared In</p>
<p class="p18">BRKOBlockDescriptor.h</p>
<b>blockRow</b>
<p class="p14">Property that identifies the corresponding block row within the game model.</p>
<p class="p15">@property (assign, nonatomic) NSInteger blockRow</p>
<p class="p19"><b></b><br></p>
<p>Discussion</p>
<p class="p14">Property that identifies the corresponding block row within the game model.</p>
<p>Declared In</p>
<p class="p18">BRKOBlockDescriptor.h</p>
<p class="p21"><br></p>
<b>blockStrength</b>
<p class="p14">Property that identifies the block strength indicator of the corresponding block within the game model.</p>
<p class="p15">@property (assign, nonatomic) NSInteger blockStrength</p>
<p class="p19"><b></b><br></p>
<p>Discussion</p>
<p class="p14">Property that identifies the block strength indicator of the corresponding block within the game model.</p>
<p>Declared In</p>
<p class="p18">BRKOBlockDescriptor.h</p>
<p class="p8"><br></p>
<h3>Instance Methods</h3>
<b>initWithRow:andPosition:andStrength:</b>
<p class="p14">An initializer that facilitates assignment of all of the essential properties to ensure the corresponding block within the game model is identified by instances of this class.</p>
<p class="p15">- (id)initWithRow:(NSInteger)<i>row</i> andPosition:(NSInteger)<i>position</i> andStrength:(NSInteger)<i>strength</i></p>
<p class="p17"><b>Parameters</b></p>
<p class="p20">row</p>
<p class="p14">identifier of the corresponding block row within the game model.</p>
<p class="p20">position</p>
<p class="p14">identifier of the corresponding block’s position within the row in the game model.</p>
<p class="p20">strength</p>
<p class="p14">identifies the block strength indicator of the corresponding block within the game model.</p>
<p class="p17"><b>Return Value</b></p>
<p class="p14">Pointer to a newly instantiated BRKOBlockDescriptor instance with the assigned identifiers to bind it with the corresponding block within the breakout game model.</p>
<p>Discussion</p>
<p class="p14">An initializer that facilitates assignment of all of the essential properties to ensure the corresponding block within the game model is identified by instances of this class.</p>
<p>Declared In</p>
<p class="p18">BRKOBlockDescriptor.h</p>
<p class="p22"><br></p>
<p class="p23">© 2014 Appivot. All rights reserved. (Last updated: 2014-11-25)<span class="s4"><br>
</span><span class="s5">Generated by </span><span class="s6">appledoc 2.2 (build 963)</span><span class="s5">.</span></p>
<p class="p24"><br></p>
<p class="p24"><br></p>
<h2>BRKOPlayersManager Class Reference</h2>
<table cellspacing="0" cellpadding="0" class="t1">
  <tbody>
    <tr>
      <td valign="top" class="td1">
        <p class="p7"><b>Inherits from</b></p>
      </td>
      <td valign="top" class="td7">
        <p class="p7">NSObject</p>
        <p class="p25"><br></p>
      </td>
    </tr>
    <tr>
      <td valign="top" class="td1">
        <p class="p7"><b>Declared in</b></p>
      </td>
      <td valign="top" class="td7">
        <p class="p7">BRKOPlayersManager.h</p>
        <p class="p7">BRKOPlayersManager.m</p>
      </td>
    </tr>
  </tbody>
</table>
<p class="p8"><br></p>
<h3>Overview</h3>
<p class="p10">A controller class that facilitates access to and management of a group of players of a game of breakout.</p>
<h3>Tasks</h3>
<ul class="ul1">
  <li class="li11">– allPlayers</li>
  <li class="li11">– addPlayer:</li>
  <li class="li11">– removePlayer:</li>
</ul>
<h3>Instance Methods</h3>
<b>addPlayer:</b>
<p class="p14">Adds a player to the list of <span class="s1">players</span> within the <span class="s1">players</span> manager.</p>
<p class="p15">- (void)addPlayer:(BRKOPlayer *)<i>playerName</i></p>
<p class="p19"><b></b><br></p>
<p class="p17"><b>Parameters</b></p>
<p class="p20">playerName</p>
<p class="p14">The name of the player to be added.</p>
<p>Discussion</p>
<p class="p14">Adds a player to the list of <span class="s1">players</span> within the <span class="s1">players</span> manager.</p>
<p>Declared In</p>
<p class="p18">BRKOPlayersManager.h</p>
<p class="p21"><br></p>
<b>allPlayers</b>
<p class="p14">Returns a reference to the array of <span class="s1">players</span> within the instance of BRKOPlayersManager.</p>
<p class="p15">- (NSArray *)allPlayers</p>
<p class="p19"><b></b><br></p>
<p class="p17"><b>Return Value</b></p>
<p class="p14">a reference to the array of <span class="s1">players</span> within the instance of BRKOPlayersManager.</p>
<p>Discussion</p>
<p class="p14">Returns a reference to the array of <span class="s1">players</span> within the instance of BRKOPlayersManager.</p>
<p>Declared In</p>
<p class="p18">BRKOPlayersManager.h</p>
<p class="p21"><br></p>
<b>removePlayer:</b>
<p class="p14">Removes a player from the list of <span class="s1">players</span> within the <span class="s1">players</span> manager.</p>
<p class="p15">- (void)removePlayer:(BRKOPlayer *)<i>player</i></p>
<p class="p19"><b></b><br></p>
<p class="p17"><b>Parameters</b></p>
<p class="p20">player</p>
<p class="p14">The name of the player to be removed.</p>
<p>Discussion</p>
<p class="p14">Removes a player from the list of <span class="s1">players</span> within the <span class="s1">players</span> manager.</p>
<p>Declared In</p>
<p class="p18">BRKOPlayersManager.h</p>
<p class="p22"><br></p>
<p class="p23">© 2014 Appivot. All rights reserved. (Last updated: 2014-11-25)<span class="s4"><br>
</span><span class="s5">Generated by </span><span class="s6">appledoc 2.2 (build 963)</span><span class="s5">.</span></p>
<p class="p24"><br></p>
<p class="p24"><br></p>
<h2>BRKOPlayer Class Reference</h2>
<table cellspacing="0" cellpadding="0" class="t1">
  <tbody>
    <tr>
      <td valign="top" class="td1">
        <p class="p7"><b>Inherits from</b></p>
      </td>
      <td valign="top" class="td1">
        <p class="p7">NSObject</p>
        <p class="p25"><br></p>
      </td>
    </tr>
    <tr>
      <td valign="top" class="td1">
        <p class="p7"><b>Declared in</b></p>
      </td>
      <td valign="top" class="td1">
        <p class="p7">BRKOPlayer.h</p>
        <p class="p7">BRKOPlayer.m</p>
      </td>
    </tr>
  </tbody>
</table>
<p class="p8"><br></p>
<h3>Overview</h3>
<p class="p10">A model class that encapsulates information regarding a single game player.</p>
<p class="p8"><br></p>
<h3>Tasks</h3>
<ul class="ul1">
  <li class="li11">  name<span class="s2"> </span><span class="s3">property</span></li>
  <li class="li11">  turnsLeft<span class="s2"> </span><span class="s3">property</span></li>
  <li class="li11">  score<span class="s2"> </span><span class="s3">property</span></li>
  <li class="li11">  round<span class="s2"> </span><span class="s3">property</span></li>
  <li class="li11">  turnsGone<span class="s2"> </span><span class="s3">property</span></li>
  <li class="li11">– initWithName:andTurnsAtStart:</li>
  <li class="li11">– turnLost</li>
  <li class="li11">– resetForStartOfPlay</li>
</ul>
<p class="p8"><br></p>
<h3>Properties</h3>
<b>name</b>
<p class="p14">The name of the player.</p>
<p class="p15">@property (strong, nonatomic) NSString *name</p>
<p class="p19"><b></b><br></p>
<p>Discussion</p>
<p class="p14">The name of the player.</p>
<p>Declared In</p>
<p class="p18">BRKOPlayer.h</p>
<p class="p21"><br></p>
<b>round</b>
<p class="p14">The highest round the player has achieved during the current game.</p>
<p class="p15">@property (assign, nonatomic) NSInteger round</p>
<p class="p19"><b></b><br></p>
<p>Discussion</p>
<p class="p14">The highest round the player has achieved during the current game.</p>
<p>Declared In</p>
<p class="p18">BRKOPlayer.h</p>
<p class="p21"><br></p>
<b>score</b>
<p class="p14">The current score the player has earned.</p>
<p class="p15">@property (assign, nonatomic) NSInteger score</p>
<p class="p19"><b></b><br></p>
<p>Discussion</p>
<p class="p14">The current score the player has earned.</p>
<p>Declared In</p>
<p class="p18">BRKOPlayer.h</p>
<p class="p21"><br></p>
<b>turnsGone</b>
<p class="p14">A convenience flag that indicates whether or not the players turns have expired.</p>
<p class="p15">@property (assign, readonly, nonatomic) BOOL turnsGone</p>
<p class="p19"><b></b><br></p>
<p>Discussion</p>
<p class="p14">A convenience flag that indicates whether or not the players turns have expired.</p>
<p>Declared In</p>
<p class="p18">BRKOPlayer.h</p>
<b>turnsLeft</b>
<p class="p14">The number of turns the player has remaining.</p>
<p class="p15">@property (assign, nonatomic) NSInteger turnsLeft</p>
<p>Discussion</p>
<p class="p14">The number of turns the player has remaining.</p>
<p>Declared In</p>
<p class="p18">BRKOPlayer.h</p>
<p class="p8"><br></p>
<h3>Instance Methods</h3>
<b>initWithName:andTurnsAtStart:</b>
<p class="p14">An initializer that allows the essential player properties to be set</p>
<p class="p15">- (id)initWithName:(NSString *)<i>name</i> andTurnsAtStart:(NSInteger)<i>turnsAtStart</i></p>
<p class="p19"><b></b><br></p>
<p class="p17"><b>Parameters</b></p>
<p class="p20">name</p>
<p class="p14">The <span class="s1">name</span> of the player.</p>
<p class="p20">turnsAtStart</p>
<p class="p14">The initial number of turns.</p>
<p class="p17"><b>Return Value</b></p>
<p class="p14">A reference to a newly instantiated BRKOPlayer object.</p>
<p>Discussion</p>
<p class="p14">An initializer that allows the essential player properties to be set</p>
<p>Declared In</p>
<p class="p18">BRKOPlayer.h</p>
<p class="p21"><br></p>
<b>resetForStartOfPlay</b>
<p class="p14">Allows a player object to be reset to a zero <span class="s1">score</span> and a default number of turns.</p>
<p class="p15">- (void)resetForStartOfPlay</p>
<p class="p19"><b></b><br></p>
<p>Discussion</p>
<p class="p14">Allows a player object to be reset to a zero <span class="s1">score</span> and a default number of turns.</p>
<p>Declared In</p>
<p class="p18">BRKOPlayer.h</p>
<p class="p21"><br></p>
<b>turnLost</b>
<p class="p14">A method that allows a player object to be informed of a loss of turn.</p>
<p class="p15">- (void)turnLost</p>
<p class="p19"><b></b><br></p>
<p>Discussion</p>
<p class="p14">A method that allows a player object to be informed of a loss of turn.</p>
<p>Declared In</p>
<p class="p18">BRKOPlayer.h</p>
<ul class="ul2">
  <li class="li16"><br></li>
</ul>
<p class="p23">© 2014 Appivot. All rights reserved. (Last updated: 2014-11-25)<span class="s4"><br>
</span><span class="s5">Generated by </span><span class="s6">appledoc 2.2 (build 963)</span><span class="s5">.</span></p>
<p class="p24"><br></p>
<p class="p24"><br></p>
<h2>BRKOPlayersViewController Class Reference</h2>
<table cellspacing="0" cellpadding="0" class="t1">
  <tbody>
    <tr>
      <td valign="top" class="td1">
        <p class="p7"><b>Inherits from</b></p>
      </td>
      <td valign="top" class="td8">
        <p class="p7">UIViewController</p>
      </td>
    </tr>
    <tr>
      <td valign="top" class="td1">
        <p class="p7"><b>Declared in</b></p>
      </td>
      <td valign="top" class="td8">
        <p class="p7">BRKOPlayersViewController.h</p>
        <p class="p7">BRKOPlayersViewController.m</p>
      </td>
    </tr>
  </tbody>
</table>
<p class="p8"><br></p>
<h3>Overview</h3>
<p class="p10">A view controller facilitating entry of player names to play one or more games of Breakout.</p>
<p class="p22"><br></p>
<p class="p23">© 2014 Appivot. All rights reserved. (Last updated: 2014-11-24)<span class="s4"><br>
</span><span class="s5">Generated by </span><span class="s6">appledoc 2.2 (build 963)</span><span class="s5">.</span></p>
<p class="p6"><br></p>
<h2>BRKOBreakoutGameViewController Class Reference</h2>
<table cellspacing="0" cellpadding="0" class="t1">
  <tbody>
    <tr>
      <td valign="top" class="td1">
        <p class="p7"><b>Inherits from</b></p>
      </td>
      <td valign="top" class="td9">
        <p class="p7">UIViewController</p>
      </td>
    </tr>
    <tr>
      <td valign="top" class="td1">
        <p class="p7"><b>Declared in</b></p>
      </td>
      <td valign="top" class="td9">
        <p class="p7">BRKOBreakoutGameViewController.h</p>
        <p class="p7">BRKOBreakoutGameViewController.m</p>
      </td>
    </tr>
  </tbody>
</table>
<p class="p8"><br></p>
<h3>Overview</h3>
<p class="p10">A view controller that controls the view hierarchy displaying the game to the user.</p>
<p class="p8"><br></p>
<h3>Tasks</h3>
<ul class="ul1">
  <li class="li11">  playersManager<span class="s2"> </span><span class="s3">property</span></li>
</ul>
<p class="p8"><br></p>
<h3>Properties</h3>
<b>playersManager</b>
<p class="p14">A populated instance of BRKOPlayersManager for a new game of breakout to be based on.</p>
<p class="p15">@property (strong, nonatomic) BRKOPlayersManager *playersManager</p>
<p class="p19"><b></b><br></p>
<p>Discussion</p>
<p class="p14">A populated instance of BRKOPlayersManager for a new game of breakout to be based on.</p>
<p>Declared In</p>
<p class="p18">BRKOBreakoutGameViewController.h</p>
<p class="p22"><br></p>
<p class="p23">© 2014 Appivot. All rights reserved. (Last updated: 2014-11-24)<span class="s4"><br>
</span><span class="s5">Generated by </span><span class="s6">appledoc 2.2 (build 963)</span><span class="s5">.</span></p>
<p class="p24"><br></p>
<p class="p24"><br></p>
<h2>BRKOBallView Class Reference</h2>
<table cellspacing="0" cellpadding="0" class="t1">
  <tbody>
    <tr>
      <td valign="top" class="td1">
        <p class="p7"><b>Inherits from</b></p>
      </td>
      <td valign="top" class="td10">
        <p class="p7">UIView</p>
      </td>
    </tr>
    <tr>
      <td valign="top" class="td1">
        <p class="p7"><b>Declared in</b></p>
      </td>
      <td valign="top" class="td10">
        <p class="p7">BRKOBallView.h</p>
        <p class="p7">BRKOBallView.m</p>
      </td>
    </tr>
  </tbody>
</table>
<p class="p8"><br></p>
<h3>Overview</h3>
<p class="p10">A UIView subclass that represents a ball in the presentation of the game board. It’s major purpose is to ensure the tag property is assigned to the kGamePieceTagBall value so that it can be distiguished by the UIKit Dynamics logic that detects collisions.</p>
<p class="p22"><br></p>
<p class="p23">© 2014 Appivot. All rights reserved. (Last updated: 2014-11-24)<span class="s4"><br>
</span><span class="s5">Generated by </span><span class="s6">appledoc 2.2 (build 963)</span><span class="s5">.</span></p>
<p class="p24"><br></p>
<p class="p24"><br></p>
<h2>BRKOPaddleView Class Reference</h2>
<table cellspacing="0" cellpadding="0" class="t1">
  <tbody>
    <tr>
      <td valign="top" class="td1">
        <p class="p7"><b>Inherits from</b></p>
      </td>
      <td valign="top" class="td11">
        <p class="p7">UIView</p>
      </td>
    </tr>
    <tr>
      <td valign="top" class="td1">
        <p class="p7"><b>Declared in</b></p>
      </td>
      <td valign="top" class="td11">
        <p class="p7">BRKOPaddleView.h</p>
        <p class="p7">BRKOPaddleView.m</p>
      </td>
    </tr>
  </tbody>
</table>
<p class="p8"><br></p>
<h3>Overview</h3>
<p class="p10">A UIView subclass that represents a paddle in the presentation of the game board. It’s major purpose is to ensure the tag property is assigned to the kGamePieceTagPaddle value so that it can be distiguished by the UIKit Dynamics logic that detects collisions.</p>
<p class="p22"><br></p>
<p class="p23">© 2014 Appivot. All rights reserved. (Last updated: 2014-11-24)<span class="s4"><br>
</span><span class="s5">Generated by </span><span class="s6">appledoc 2.2 (build 963)</span><span class="s5">.</span></p>
<p class="p24"><br></p>
<p class="p24"><br></p>
<h2>BRKOBlockView Class Reference</h2>
<table cellspacing="0" cellpadding="0" class="t1">
  <tbody>
    <tr>
      <td valign="top" class="td1">
        <p class="p7"><b>Inherits from</b></p>
      </td>
      <td valign="top" class="td12">
        <p class="p7">UIView</p>
      </td>
    </tr>
    <tr>
      <td valign="top" class="td1">
        <p class="p7"><b>Declared in</b></p>
      </td>
      <td valign="top" class="td12">
        <p class="p7">BRKOBlockView.h</p>
        <p class="p7">BRKOBlockView.m</p>
      </td>
    </tr>
  </tbody>
</table>
<p class="p8"><br></p>
<h3>Overview</h3>
<p class="p10">A UIView subclass that represents a ball in the presentation of the game board. It’s major purpose is to store a reference to the BRKOBlockDescriptor object that uniquely identifies and binds it to its corresponding block model object. It also ensures the tag property is assigned to the kGamePieceTagBlock value so that it can be distinguished by the UIKit Dynamics logic that detects collisions.</p>
<p class="p22"><br></p>
<p class="p23">© 2014 Appivot. All rights reserved. (Last updated: 2014-11-24)<span class="s4"><br>
</span><span class="s5">Generated by </span><span class="s6">appledoc 2.2 (build 963)</span><span class="s5">.</span></p>
<p class="p24"><br></p>
<p class="p24"><br></p>
<p class="p24"><br></p>
<p class="p24"><br></p>
</body>
</html>
