new Vue({
    el: '#app',
    data() {
        return {
            playerHealth: 100,
            monsterHealth: 100,
            gameIsOn: false,
            gameIsEnded: false,
            gameWinner: "",
            turn: true,
            battleLog: []
        }
    },
    computed: {
        turnStyle: function () {
            return {
                'player-turn': this.turn,
                'monster-turn': !this.turn
            };
        }
    },
    methods: {
        playerAttack: function () {
            this.attack("Player", 0);
            this.attack("Monster", 1);
        },
        playerSpecialAttack: function () {
            this.attack("Player", 1);
            this.attack("Monster", 1);
        },
        playerHeal: function () {
            const healthRestored = Math.floor(Math.random() * 20) + 1;
            this.playerHealth += healthRestored;
            this.logAction("Player restored " + healthRestored + " health points!");
            this.attack("Monster", 1);
        },
        attack(who, modifier) {
            if (who == "Player") {
                const attackPower = modifier ? Math.floor(Math.random() * 40) + 1 : Math.floor(Math.random() * 20) + 1;
                this.monsterHealth -= attackPower;
                this.logAction("Monster received " + attackPower + " points of damage!");
            } else {
                const attackPower = Math.floor(Math.random() * 40) + 1;
                this.playerHealth -= attackPower;
                this.logAction("Player received " + attackPower + " points of damage!");
            }
            this.gameFinished();
        },
        logAction: function (attackMessage, turn) {
            this.battleLog.push(attackMessage);
            this.turn = !this.turn;
        },
        gameFinished: function () {
            if (this.monsterHealth <= 0) {
                this.gameIsEnded = true;
                this.gameIsOn = false;
                this.gameWinner = "Player";
                this.battleLog.push("Player is a winner!");
            } else if (this.playerHealth <= 0) {
                this.gameIsEnded = true;
                this.gameIsOn = false;
                this.gameWinner = "Monster";
                this.battleLog.push("Monster is a winner!");
            }
        },
        giveUp: function () {
            this.gameIsEnded = true;
            this.gameIsOn = false;
            this.turn = false;
            this.battleLog.push("Monster is a winner!");
            this.gameWinner = "Monster";
        },
        startGame: function () {
            this.gameIsOn = true;
            this.playerHealth = 100;
            this.gameIsEnded = false;
            this.monsterHealth = 100;
            this.gameWinner = "";
            this.battleLog = [];
            this.turn = true;
        }
    }
})